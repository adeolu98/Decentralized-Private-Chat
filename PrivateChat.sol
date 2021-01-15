  pragma solidity 0.4.26;
  
  contract DecentralizedChat{
      address Communicator1;
      address Communicator2;
      string message;
      
      
      constructor (address _Communicator1) public {
          
          Communicator1 = _Communicator1;
      }
      
      
      function setSecondCommunicator(address _Communicator2){
          require (msg.sender == Communicator1, 'only chatroom owner can add other participants');
          Communicator2 = _Communicator2;
      }
      
      
      function inputMessage( string _message) public view returns(string){
          require( msg.sender == Communicator2 || msg.sender == Communicator1, 'you cant send messages in this chat');
          message = _message;
          return message;
      }
           function readMessage() public view returns(string){
          require ( msg.sender == Communicator2 || msg.sender == Communicator1, 'you cant read messages in this chat');
          
          return message;
      }
  }