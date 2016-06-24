contract ContractDatabase{


    struct StorageContract {
        address owner;
        address farmer;
        uint expireDate;
        bytes32 ipfsAddress;

        // possibile bloccare i fondi di pagamento
        // direttamente nel contratto?
        // uint amount;
    }


    uint numContracts = 0;
    mapping(address => uint[]) contractIndex;

    mapping(uint => StorageContract) public contracts;


    function getContracts(address owner) returns (uint[] contractList){
        uint[] list = contractIndex[owner];
        return list;
    }

    function newContract(address owner, address farmer, uint expireDate, bytes32 ipfsAddress) returns (uint contractID){
        contractID = numContracts++;
        contracts[contractID] = StorageContract(owner, farmer, expireDate, ipfsAddress);

        contractIndex[owner].push(contractID);
        contractIndex[farmer].push(contractID);
    }
}
