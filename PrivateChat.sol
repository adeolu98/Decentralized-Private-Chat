  pragma solidity 0.8.0;
  // smart contract for sending messaes between two participants 
  
  contract DecentralizedChat{
      address Communicator1;
      address Communicator2;
      mapping (address => mapping(uint => string)) MessageSent;  
      mapping (address => mapping(string => mapping (uint => uint))) messageIndex;
      mapping (address=> uint) public numOfMessagesSent;
      mapping(address => mapping(uint => mapping(string => uint)))timeOfMessage;
      
      
      constructor (address _Communicator1, address _Communicator2) {
          require (_Communicator1 != _Communicator2, 'you cant chat with yourself');
          Communicator1 = _Communicator1;
          Communicator2 = _Communicator2;
      }
      
      function inputMessage( string memory _message) public {
          require( msg.sender == Communicator2 || msg.sender == Communicator1, 'you cant send messages in this chat');
          numOfMessagesSent[msg.sender] = numOfMessagesSent[msg.sender] + 1;
          MessageSent[msg.sender][numOfMessagesSent[msg.sender]] = _message;
          messageIndex[msg.sender][_message][block.timestamp] = numOfMessagesSent[msg.sender];
          timeOfMessage[msg.sender][numOfMessagesSent[msg.sender]][_message] = block.timestamp;
      }
      
      function readMessagebyIndex( address _Communicator, uint index) public view returns(string memory){
          require( msg.sender == Communicator2 || msg.sender == Communicator1, 'you cant read messages in this chat');
          require(_Communicator == Communicator2 || _Communicator == Communicator1, 'only read mesaages of recongnized communicators');
          
          return MessageSent[_Communicator][index];
      }

      function getIndexOfMessage(address _Communicator, string memory message, uint _timestamp) public view returns(uint){
          require( msg.sender == Communicator2 || msg.sender == Communicator1, 'you cant read messages in this chat');
          require(_Communicator == Communicator2 || _Communicator == Communicator1, 'only read mesaages of recongnized communicators');
          require(messageIndex[_Communicator][message][_timestamp] != 0, 'this message has not been sent yet');
          require(_timestamp != 0, 'timestamp cannot be zero');
          
          return messageIndex[_Communicator][message][_timestamp];
      }
      
        function getTimeOfMessage(address _Communicator, string memory message, uint _index) public view returns(uint){
          require( msg.sender == Communicator2 || msg.sender == Communicator1, 'you cant read messages in this chat');
          require(_Communicator == Communicator2 || _Communicator == Communicator1, 'only read mesaages of recongnized communicators');
          require(timeOfMessage[msg.sender][_index][message] != 0, 'this message has not been sent yet or wrong index');
          require(_index != 0, 'index cannot be zero');
          
          return timeOfMessage[msg.sender][_index][message];
      }
  }