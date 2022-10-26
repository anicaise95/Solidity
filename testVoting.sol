const SimpleStorage = artifacts.require("./contrats/SimpleStorage");
const { BN, expectRevert, expectEvent } = require('@openzeppelin/test-helpers');
const { expect } = require('chai');


contract("SimpleStorage", accounts => {

    beforeEach(async function () {
        SimpleStorageInstance = await SimpleStorage.new({ from: _owner });
    });

    it("Le set doit être superieur à 0", async () => {

        // Test du cas ou le votant n'est pas enregistré
        expectEvent(await SimpleStorageInstance.set(0), "Num doit etre > 0");

        // Test du cas ou le votant est enregistré
        //expectRevert(await SimpleStorageInstance.addVoter(adress_voter1), "Already registered");

        // Test emit

    });

})
