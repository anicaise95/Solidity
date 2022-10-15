// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SytemeVoteEleves is Ownable {

    enum Matiere { MATHS, FRANCAIS, PHYSIQUE, ANGLAIS}

    // Une adresse => un professeur
    mapping(address => Matiere) professeurs;

    // Une classe => une liste d'étudiants
    mapping(string => Student[]) classes;
    // La liste des étudiants
    Student[] students;
    
    struct Student {  
        address adresse;
        string nom;
        string prenom;
        Matieres[] matieres;
        uint moyenneGenerale;
    }

    struct Matieres {
        Matiere matiere;
        uint[] notes;
        uint moyenne; 
    }

    Matiere matieres;

    mapping(Matiere => uint) moyennesParMatiere;

    constructor(){
        // Initialisation de mapping Address/Matiere
        professeurs[address(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2)] = Matiere.MATHS;
        professeurs[address(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db)] = Matiere.FRANCAIS;
        professeurs[address(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB)] = Matiere.PHYSIQUE;
        professeurs[address(0x617F2E2fD72FD9D5503197092aC168c91465E7f2)] = Matiere.ANGLAIS;
    }

    // Retourne l'index de l'éleve dans la classe
    function getEtudiantParNom(string memory _nom, string memory _classe) public view returns (uint){
        for (uint i = 0; i < classes[_classe].length; i++) {
            if ( keccak256( abi.encodePacked(classes[_classe][i].nom) ) == keccak256( abi.encodePacked(_nom) ) ){
                return i;
            }
        } 
    }

    function ajouterEtudiant(address _adrStudent, string memory _nom, string memory _prenom, string memory _classe) public onlyOwner {
        Student memory student; //= Student(_adrStudent, _nom, _prenom, new Matiere[], 0);
        student.adresse = _adrStudent;
        student.prenom = _prenom;
        student.nom = _nom;
        students.push(student);
    
        // MAJ du storage
        uint index = getEtudiantParNom(_nom, _classe); // ou index = classes[_classe].length;
        students[index].matieres.push(Matieres(Matiere.MATHS, new uint[](0), 0));
        students[index].matieres.push(Matieres(Matiere.FRANCAIS, new uint[](0), 0));
        students[index].matieres.push(Matieres(Matiere.PHYSIQUE, new uint[](0), 0));
        students[index].matieres.push(Matieres(Matiere.ANGLAIS, new uint[](0), 0));

        classes[_classe] = students;
    }

    function isProfesseur(Matiere matiereProf) private pure returns (bool output){
        if(matiereProf == Matiere.MATHS || matiereProf == Matiere.FRANCAIS || matiereProf == Matiere.PHYSIQUE || matiereProf == Matiere.ANGLAIS){
            return true;
        }
        return false;
    }

    // Le professeur ajoute la note de l'élève
    function addNote(string memory _nom, string memory _classe, uint _note) public {
        // On récupère la matière du porof en fonction de son adresse
        Matiere matiereNoteeByProf = professeurs[msg.sender];
        // Sil est bien reconnu comme professeur
        require(isProfesseur(matiereNoteeByProf), unicode"Seuls les profs sont autorisés");

        uint index = getEtudiantParNom(_nom, _classe);

        // On boucle sur chaque matière       
        for (uint i = 0; i < students[index].matieres.length; i++){
            // On chercher la matière correspondant au professeur qui renseige la note
            if(students[index].matieres[i].matiere == matiereNoteeByProf){
                // Le prof enregistre la note de l'étudiant 
                students[index].matieres[i].notes.push(_note);
            }
        }
    }

    function calculerMoyenneEtudiantParMatiere(string memory _nom, string memory _classe) public {

        uint index = getEtudiantParNom(_nom, _classe);

        // Pour chaque matiere de l'éleve
        for (uint i = 0; i < students[index].matieres.length; i++){

            uint sommeNotes = 0;
            uint nbNotes = 0;

            // on calcule la moyenne des notes
            for (uint j = 0; j < students[index].matieres[i].notes.length; i++){
                uint note = students[index].matieres[i].notes[j];
                sommeNotes += note;
                nbNotes++;
            }

            students[index].matieres[i].moyenne = sommeNotes * 100 / nbNotes;           
        }
    }

    function calculerMoyenneClasseParMatiere(string memory _nom, string memory _classe) public {

    }

    function calculerMoyenneGeneraleEtudiant(string memory _nom, string memory _classe) public {

        uint index = getEtudiantParNom(_nom, _classe);
        uint sommeMoyennesParMatiere = 0;
        uint nbMatieres = students[index].matieres.length;
        uint moyenneGenerale = 0;

        // Pour chaque matiere de l'éleve
        for (uint i = 0; i < students[index].matieres.length; i++){
            // Sommes des moyennes (préalablement calculées via calculerMoyenneEtudiantParMatiere)
            sommeMoyennesParMatiere += students[index].matieres[i].moyenne;         
        }

        moyenneGenerale = sommeMoyennesParMatiere * 100 / nbMatieres;
        students[index].moyenneGenerale = moyenneGenerale; 
    }

    function calculerMoyenneGeneraleClasse() public {

    }

    /*
    function getMoyenneParMatiere(address _adrStudent) public returns (mapping memory){
        for (uint i = 0; i < students[_adrStudent].matieres.length; i++){
            moyennesParMatiere[students[_adrStudent].matieres[i].matiere] = students[_adrStudent].matieres[i].moyenne;           
        }
        return moyennesParMatiere;
    }*/

    function getMoyenneGenerale(string memory _nom, string memory _classe) public view returns (uint){
        uint index = getEtudiantParNom(_nom, _classe);
        return students[index].moyenneGenerale;
    }

} 
