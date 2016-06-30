contract ContractDatabase{


    struct StorageContract {
        address owner;
        address farmer;
        uint duration;
        bytes32 ipfsAddress;

        // possibile bloccare i fondi di pagamento
        // direttamente nel contratto?
        uint amount;

        //isStarted?
        //alla prima transazione del farmer parte il contratto?
        //startTime?
        //tempo della prima transazione
        //amountPerDay?
    }


    uint numContracts = 0;
    mapping(address => uint[]) contractIndex;

    mapping(uint => StorageContract) public contracts;


    function getContracts(address owner) constant returns (uint[] contractList){
        return contractIndex[owner];
    }

    function newContract(address owner, address farmer, uint duration, bytes32 ipfsAddress) returns (uint contractID){
        contractID = numContracts++;
        contracts[contractID] = StorageContract(owner, farmer, duration, ipfsAddress, msg.value);

        contractIndex[owner].push(contractID);
        contractIndex[farmer].push(contractID);
    }
}
