// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SytemeVoteEleves is Ownable {

    enum Matiere{ MATHS, FRANCAIS, PHYSIQUE, ANGLAIS}
    // Une adresse un professeur
    mapping(address => Matiere) professeurs;
    
    struct Student {  
        string lastname;
        string firstname;
        Matieres[] matieres;
        uint moyenneGenerale;
    }

    struct Matieres {
        Matiere matiere;
        uint[] notes;
        uint moyenne; 
    }

    mapping(address => Student) public students;
   
    Matiere matieres;

    mapping(Matiere => uint) moyennesParMatiere;

    constructor(){
        // Initialisation de mapping Address/Matiere
        professeurs[address(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2)] = Matiere.MATHS;
        professeurs[address(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db)] = Matiere.FRANCAIS;
        professeurs[address(0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB)] = Matiere.PHYSIQUE;
        professeurs[address(0x617F2E2fD72FD9D5503197092aC168c91465E7f2)] = Matiere.ANGLAIS;
    }

    function addStudent(address _adrStudent, string memory _firstname, string memory _lastname) public onlyOwner {
        students[_adrStudent].firstname = _firstname;
        students[_adrStudent].lastname = _lastname;
        students[_adrStudent].matieres.push(Matieres(Matiere.MATHS, new uint[](0), 0));
        students[_adrStudent].matieres.push(Matieres(Matiere.FRANCAIS, new uint[](0), 0));
        students[_adrStudent].matieres.push(Matieres(Matiere.PHYSIQUE, new uint[](0), 0));
        students[_adrStudent].matieres.push(Matieres(Matiere.ANGLAIS, new uint[](0), 0));
    }

    function isProfesseur(Matiere matiereProf) private pure returns (bool output){
        if(matiereProf == Matiere.MATHS || matiereProf == Matiere.FRANCAIS || matiereProf == Matiere.PHYSIQUE || matiereProf == Matiere.ANGLAIS){
            return true;
        }
        return false;
    }

    // Le professeur ajoute la note de l'élève
    function addNote(address _adrStudent, uint _note) public {
        // On récupère la matière du porof en fonction de son adresse
        Matiere matiereNoteeByProf = professeurs[msg.sender];
        // Sil est bien reconnu comme professeur
        require(isProfesseur(matiereNoteeByProf), unicode"Seuls les profs sont autorisés");

        // On boucle sur chaque matière       
        for (uint i = 0; i < students[_adrStudent].matieres.length; i++){
            // On chercher la matière correspondant au professeur qui renseige la note
            if(students[_adrStudent].matieres[i].matiere == matiereNoteeByProf){
                // Le prof enregistre la note de l'étudiant 
                students[_adrStudent].matieres[i].notes.push(_note);
            }
        }
    }

    function calculerMoyenneEtudiantParMatiere(address _adrStudent) public {

        // Pour chaque matiere de l'éleve
        for (uint i = 0; i < students[_adrStudent].matieres.length; i++){

            uint sommeNotes = 0;
            uint nbNotes = 0;

            // on calcule la moyenne des notes
            for (uint j = 0; j < students[_adrStudent].matieres[i].notes.length; i++){
                uint note = students[_adrStudent].matieres[i].notes[j];
                sommeNotes += note;
                nbNotes++;
            }

            students[_adrStudent].matieres[i].moyenne = sommeNotes * 100 / nbNotes;           
        }
    }

    function calculerMoyenneClasseParMatiere() public {

    }

    function calculerMoyenneGeneraleEtudiant(address _adrStudent) public {

         uint sommeMoyennesParMatiere = 0;
         uint nbMatieres = students[_adrStudent].matieres.length;
         uint moyenneGenerale = 0;

        // Pour chaque matiere de l'éleve
        for (uint i = 0; i < students[_adrStudent].matieres.length; i++){
            // Sommes des moyennes (préalablement calculées via calculerMoyenneEtudiantParMatiere)
            sommeMoyennesParMatiere += students[_adrStudent].matieres[i].moyenne;         
        }

        moyenneGenerale = sommeMoyennesParMatiere * 100 / nbMatieres;
        students[_adrStudent].moyenneGenerale = moyenneGenerale; 
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

    function getMoyenneGenerale(address _adrStudent) public view returns (uint){
        return students[_adrStudent].moyenneGenerale;
    }

} 
