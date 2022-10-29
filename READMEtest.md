# Projet Voting : tests unitaires

[![forthebadge](https://img.shields.io/badge/Solidity-e6e6e6?style=for-the-badge&logo=solidity&logoColor=black)](http://forthebadge.com), [![forthebadge](https://img.shields.io/badge/OpenZeppelin-4E5EE4?logo=OpenZeppelin&logoColor=fff&style=for-the-badge)](http://forthebadge.com)


### Installation de Truffle

```
# Installation globale
$ npm install -g truffle

# Installation locale (dans le répertoire courant)
$ npm install truffle --prefix . 
```

### Pré-requis

- Le fichier Voting.sol (répertoire "contracts")
- Le fichier TestVoting.sol (répertorie "tests")

### Initialisation de truffle

Pour éxécuter nos tests via truflle : 

Dans notre projet, configurer truffle via la commande ``$ truffle init`` 

## Démarrage des tests

Executez la commande :
```
$ truffle test
```

## Tests réalisés
  
    Contract: Voting

    // ::::::::::::: REGISTRATION ::::::::::::: //
      ✓ Début des enregistrements
      ✓ Seul l'administrateur est habilité à ajouter un électeur
      ✓ L'administrateur ajoute des electeurs sur la whitelist (100440 gas)
      ✓ Un électeur ne peut pas être ajouté 2 fois (50220 gas)
    // ::::::::::::: PROPOSAL ::::::::::::: //
      ✓ Un électeur absent de la whitelist ne peut pas ajouter de proposition
      ✓ Un électeur ne peut pas ajouter une proposition avant l'ouverture de la session d'enregistrement (50220 gas)
      ✓ L'adminisrateur ouvre la session d'enregistrement des propositions (145252 gas)
      ✓ Un électeur ne peut pas ajouter une proposition vide (145252 gas)
      ✓ Des électeurs ajoutent des propositions (373744 gas)
      ✓ L'administrateur cloture la session d'enregistrement (235299 gas)
    // ::::::::::::: VOTE ::::::::::::: //
      ✓ Un électeur absent de la whitelist ne peut pas voter
      ✓ Un électeur ne peut pas voter si la session de vote n'est pas ouverte (235299 gas)
      ✓ L'administrateur ouvre la session de vote (265853 gas)
      ✓ L'électeur vote (une seule fois) pour sa proposition préférée (754329 gas)
      ✓ L'administrateur cloture la session des votes (374399 gas)
    // ::::::::::::: RESULTS ::::::::::::: //
      ✓ L'administrateur désigne le vainqueur (1224746 gas)
      
      
      ·------------------------------------------|----------------------------|-------------|----------------------------·
      |   Solc version: 0.8.17+commit.8df45f5f   ·  Optimizer enabled: false  ·  Runs: 200  ·  Block limit: 6718946 gas  │
      ···········································|····························|·············|·····························
      |  Methods                                                                                                         │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Contract  ·  Method                     ·  Min        ·  Max         ·  Avg        ·  # calls     ·  eur (avg)  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  addProposal                ·      59340  ·      104114  ·      64380  ·          18  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  addVoter                   ·          -  ·           -  ·      50220  ·          22  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  endProposalsRegistering    ·          -  ·           -  ·      30599  ·           8  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  endVotingSession           ·          -  ·           -  ·      30533  ·           3  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  setVote                    ·      60913  ·       78013  ·      76113  ·           9  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  startProposalsRegistering  ·          -  ·           -  ·      95032  ·          11  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  startVotingSession         ·          -  ·           -  ·      30554  ·           5  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  tallyVotes                 ·          -  ·           -  ·      72285  ·           1  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Deployments                             ·                                          ·  % of limit  ·             │
      ···········································|·············|··············|·············|··············|··············
      |  Voting                                  ·          -  ·           -  ·    2077414  ·      30.9 %  ·          -  │
      ·------------------------------------------|-------------|--------------|-------------|--------------|-------------·
      
      16 passing (28s)

## Ressources

Programmes / logiciels / ressources utilisées ici : 

* [Solidity](https://atom.io/) - Editeur de textes

## Documentation

- Suite Truffle (https://trufflesuite.com/docs/truffle/testing/writing-tests-in-solidity/)

## Versions


## Auteurs
Listez le(s) auteur(s) du projet ici !
* **Alexandre NICAISE** (https://github.com/anicaise95) Formation Alyra @ 2022

## License

MIT
