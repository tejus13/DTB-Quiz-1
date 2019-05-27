pragma solidity ^0.4.24;

contract TicTacToe {
    uint[] board = new uint[](9);
    address player1;
    address player2;
    uint start = 0;
   
   
    //This makes sure that quizMaster cannot become a particiant
    modifier notPlayer1(){
        require(msg.sender!=player1,"Player1 Player2 can't be same");
    _;}
   
    //By default the player1 is initiaing the game , on the other hand player2 is registering as player2
    constructor ()
    public
    {
        player1 = msg.sender;
    }
   
    function joinGame()
    public
    notPlayer1()
    {
        player2 = msg.sender;
    }
   
    uint[][]  winning_Positions = [[0,1,2], [0,3,6],[2,5,8],[3,4,5],[2,4,6],[6,7,8],[1,4,7],[0,4,8] ];
   
    function checkWinner()
    public
    constant
    returns (uint)
    {
        for(uint i =0; i < 8;i++){
            uint[] memory a = winning_Positions[i];
            if(board[a[0]] != 0 && board[a[0]] == board[a[1]] && board[a[0]] == board[a[2]])
                return board[a[0]];
        }
        return 0;
    }
   
    function PlayMove(uint pos)
    public
    returns (string)
    {
       
         uint winner = checkWinner();
        if(winner == 1){
            return "Game Over,Winner :X";
        }
        if (winner == 2){
            return "Game Over,Winner :O";
        }
        // correct users is on turn
        if(start == 0){
            if(msg.sender != player1) return "Sorry..!! Not Player 1";
        }else if(start == 1){
            if(msg.sender != player2) return "Sorry..!! Not Player 2";
        }
       
        // is on the board
        if(pos < 0 || pos >= 9) return "not on the board";
       
        // Is not already set
        if(board[pos] != 0) return "already occupied";
       
        board[pos] = start+1;
        start = 1- start;

        return "Done";  
    }
   
    function getWinner()
    public
    constant
    returns(string, string)
    {
        string memory text = "No winner yet";
        uint winner = checkWinner();
        if(winner == 1){
            text = "Winner: X";
        }
        if (winner == 2){
            text = "Winner: O";
        }
       
       
        bytes memory out = new bytes(11);
        byte[] memory signs = new byte[](3);
        signs[0] = "-";
        signs[1] = "X";
        signs[2] = "O";
        bytes(out)[3] = "|";
        bytes(out)[7] = "|";
       
        for(uint i =0; i < 9;i++){
            bytes(out)[i + i/3] = signs[board[i]];
           
        }
       
        return (text, string(out));
    }
   
}
