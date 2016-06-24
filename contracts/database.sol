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


    struct Account{
        uint[] contractList;
    }

    uint numContracts;
    mapping(uint => StorageContract) public contracts;
    mapping(address => Account) contractRegistry;


    function ContractDatabase(){
    numContracts = 0;
    }

    function relatedContracts(address owner) returns (uint[]){
        Account c = contractRegistry[owner];
        return c.contractList;
    }

    function newContract(address owner, address farmer, uint expireDate, bytes32 ipfsAddress) returns (uint contractID){
        contractID = numContracts++;
        contracts[contractID] = StorageContract(owner, farmer, expireDate, ipfsAddress);

        contractRegistry[owner].contractList.push(contractID);
        contractRegistry[farmer].contractList.push(contractID);
    }
}
