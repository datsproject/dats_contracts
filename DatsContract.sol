// SPDX-License-Identifier: Unlicensed
pragma solidity >=0.7.0 <0.9.0;

contract DatsContract{

    /*
        DDos Service,
        Super Computer Service,
        Cyber Security Research Service,
        Vulnerability Research Service,
        Blockchain Security Service
    */

    struct DDos {
        uint256 id;
        bool isApprove;
        uint8 trafficScale;
    }

    struct SuperComputer {
        uint256 id;
        bool isApprove;
        uint8 cpuValue;
    }

    struct CyberSecurity {
        uint256 id;
        bool isApprove;
        bool webSecurity;
        bool serverSecurity;
        bool ransomwareResearch;
        bool malwareResearch;
    }

    struct Vulnerability {
        uint256 id;
        bool isApprove;
        bool webPenetration;
        bool serverPenetration;
        bool scadaPenetration;
        bool blockchainPenetration;
        bool contractPenetration;
    }

    struct Blockchain {
        uint256 id;
        bool approveAttackPrevention;
    }

    address public owner;

    mapping(address => DDos) public ddoses;
    address[] public ddosUsers;

    mapping(address => SuperComputer) public supers;
    address[] public superUsers;

    mapping(address => CyberSecurity) public cybers;
    address[] public cyberUsers;

    mapping(address => Vulnerability) public vulnerabilities;
    address[] public vulnerabilityUsers;

    mapping(address => Blockchain) public blockchains;
    address[] public blockchainUsers;

    constructor(){
        owner = msg.sender;
    }


    function saveDDos(bool _isApprove, uint8 _trafficScale) isDDosExistsByUser(msg.sender) external {

        DDos memory ddos = DDos({
            id: ddosUsers.length + 1,
            isApprove: _isApprove,
            trafficScale: _trafficScale
        });

        ddoses[msg.sender] = ddos; 
        ddosUsers.push(msg.sender);
    }

    function updateDDos(bool _isApprove, uint8 _trafficScale) external {
        DDos memory ddos = ddoses[msg.sender];
        ddos.isApprove = _isApprove;
        ddos.trafficScale = _trafficScale;

        ddoses[msg.sender] = ddos;
    }

    function deleteDDos() external {
        delete(ddoses[msg.sender]);
    }

    function getDDos() external view returns (DDos memory) {
        return ddoses[msg.sender];
    }

    function getDDosByUser(address _user) external view returns (DDos memory){
        return ddoses[_user];
    }

    function getDdosCount() external view returns(uint256) {
        return ddosUsers.length;
    }

    function saveSuperComputer(bool _isApprove, uint8 _cpuValue) external {
        SuperComputer memory superComputer = SuperComputer({
            id: superUsers.length + 1,
            isApprove: _isApprove,
            cpuValue: _cpuValue
        });

        supers[msg.sender] = superComputer;
        superUsers.push(msg.sender);
    }

    function getSuperComputer() external view returns (SuperComputer memory) {
        return supers[msg.sender];
    }

    function getSuperComputerByUser(address _user) external view returns (SuperComputer memory){
        return supers[_user];
    }

    function getSuperComputerCount() external view returns(uint256) {
        return superUsers.length;
    }
    
    function saveCyberSecurity(bool _isApprove, bool _webSecurity, bool _serverSecurity, bool _ransomwareResearch, bool _malwareResearch) external {
        CyberSecurity memory cyberSecurity = CyberSecurity({
            id: cyberUsers.length + 1,
            isApprove: _isApprove,
            webSecurity: _webSecurity,
            serverSecurity: _serverSecurity,
            ransomwareResearch: _ransomwareResearch,
            malwareResearch: _malwareResearch
        });

        cybers[msg.sender] = cyberSecurity;
        cyberUsers.push(msg.sender);
    }

    modifier isDDosExistsByUser(address _user) {
        require(ddoses[_user].id == 0, "Ddos already saved for this user");
        _;
    }

    modifier isSuperComputerExistsByUser(address _user) {
        require(supers[_user].id == 0, "SuperComputer already saved for this user");
        _;
    }

}