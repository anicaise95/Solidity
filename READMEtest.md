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

- Toutes les fonctionnalités ont été testées. 
- Dans un premier temps, je teste l'accès aux fonctions en m'assut=rant qu'il s'agit du owner ou du voter selon les fonctions à appeler
- Je vérifie également, qu'au statut initial l'apel aux fonctions REVERT (execptés pour addVoter)
- Je fais enseuite une serie de tests par fonctionnalité.
- Pour la factorisation de cote, le code duppliqué dans mes différents tests a été copié dans le BeforeEach.

  
       Contract: Voting
          // xxxxxxxx Controles de sécurité xxxxxxxxx //
            ✓ REVERT if the caller is not the owner
            ✓ REVERT if the caller is not a voter
            ✓ REVERT if the expected workflow is different (50220 gas)
          // ::::::::::::: REGISTRATION ::::::::::::: //
            ✓ L'administrateur ajoute des electeurs sur la whitelist (100440 gas)
            ✓ Un électeur ne peut pas être ajouté 2 fois sur la whitelist (50220 gas)
          // ::::::::::::: PROPOSAL ::::::::::::: //
            ✓ L'adminisrateur ouvre la session d'enregistrement des propositions (95032 gas)
            ✓ Un électeur ne peut pas ajouter une proposition vide (95032 gas)
            ✓ Des électeurs ajoutent des propositions (323524 gas)
            ✓ L'administrateur cloture la session d'enregistrement (185079 gas)
          // ::::::::::::: VOTE ::::::::::::: //
            ✓ L'administrateur ouvre la session de vote (61153 gas)
            ✓ L'électeur vote (une seule fois) pour sa proposition préférée (499409 gas)
            ✓ L'administrateur cloture la session des votes (169699 gas)
          // ::::::::::::: RESULTS ::::::::::::: //
            ✓ L'administrateur désigne le vainqueur (1224746 gas)

      ·------------------------------------------|----------------------------|-------------|----------------------------·
      |   Solc version: 0.8.17+commit.8df45f5f   ·  Optimizer enabled: false  ·  Runs: 200  ·  Block limit: 6718946 gas  │
      ···········································|····························|·············|·····························
      |  Methods                                                                                                         │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Contract  ·  Method                     ·  Min        ·  Max         ·  Avg        ·  # calls     ·  eur (avg)  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  addProposal                ·      59340  ·      104114  ·      64670  ·          17  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  addVoter                   ·          -  ·           -  ·      50220  ·          23  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  endProposalsRegistering    ·          -  ·           -  ·      30599  ·           6  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  endVotingSession           ·          -  ·           -  ·      30533  ·           3  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  setVote                    ·      60913  ·       78013  ·      76113  ·           9  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  startProposalsRegistering  ·          -  ·           -  ·      95032  ·          10  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  startVotingSession         ·          -  ·           -  ·      30554  ·           5  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Voting    ·  tallyVotes                 ·          -  ·           -  ·      72285  ·           1  ·          -  │
      ·············|·····························|·············|··············|·············|··············|··············
      |  Deployments                             ·                                          ·  % of limit  ·             │
      ···········································|·············|··············|·············|··············|··············
      |  Voting                                  ·          -  ·           -  ·    2077414  ·      30.9 %  ·          -  │
      ·------------------------------------------|-------------|--------------|-------------|--------------|-------------·

        13 passing (25s)

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
