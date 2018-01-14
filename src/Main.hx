/*

	a "collab" with noa_cubestudio
	based on a misunderstanding

	https://twitter.com/noa_cubestudio/status/952328608219099140
*/
import haxegon.*;
import StringTools;

#if js
import js.Browser;
#end

class Main {
	var recessedBackgroundCol:Int = 0x392C1B;

	var backgroundCol:Int = Col.DARKBROWN;
	
	var buttonCol = Col.BROWN;
	var buttonHighlightCol = Col.ORANGE;

	var redButtonCol = Col.BROWN;
	var redButtonHighlightCol = Col.ORANGE;
	
	var textCol = Col.YELLOW;
	var statusTextCol = Col.WHITE;

	var currentBalance:Int=0;
	var newBalance:Int=0;


	function itos(i:Int,digits:Int):String{
		var s = Std.string(i);
		while (s.length<digits){
			s = "0"+s;
		}
		return s;
	}

	function drawButton(text,x,y,textcolor,color,colorhover,returnhoverstatus=false) {
	  var width=39;
	  var w = Math.round(Text.width(text));
	  if (w+6>=width){
	  	width=w+6;
	  }
	  var height=7;
	  var dx = Mouse.x-x;
	  var dy = Mouse.y-y;

	  var collide = !(dx<0||dx>=width||dy<0||dy>=height);

	  var click = collide && Mouse.leftclick();

	  if (collide&& !click){
	    color=colorhover;
	  }
	  Gfx.fillbox(x,y,width,height,color);
	  Text.display(x+2, y+1, text, textcolor);
	  
	  if (returnhoverstatus==true){
	  	click=collide;
	  }
	  return click;
	}

	function drawSmallButton(text,x,y,textcolor,color,colorhover,returnhoverstatus=false) {
	  var width=7;
	  var w = Math.round(Text.width(text));
	  if (w+5>=width){
	  	width=w+5;
	  }
	  var height=7;
	  var dx = Mouse.x-x;
	  var dy = Mouse.y-y;

	  var collide = !(dx<0||dx>=width||dy<0||dy>=height);
	  
	  var mb = Mouse.leftclick();
	  var click = collide && mb;
	  if (Input.justpressed(alphamap[text])){
	  	click=true;
	  	collide=true;
	  }
	  if (collide&& !click){
	    color=colorhover;
	  }
	  Gfx.fillbox(x,y,width,height,color);
	  Text.display(x+3, y+1, text, textcolor);
	  
	  if (returnhoverstatus==true){
	  	click=collide;
	  }
	  return click;
	}


	function new(){		
		Text.font = "pixel";
		Text.size = 1;
	}


	function twi(str){
		return Math.round(Text.width(str));
	}
	  
	var charmasks = [
		[ //A
			"111",
			"101",
			"111",
			"101",
			"101"
		],
		[ //B
			"100",
			"100",
			"111",
			"101",
			"111"
		],
		[ //C
			"111",
			"100",
			"100",
			"100",
			"111"
		],
		[ //D
			"001",
			"001",
			"111",
			"101",
			"111"
		],
		[ //E
			"111",
			"100",
			"111",
			"100",
			"111"
		],
		[ //F
			"111",
			"100",
			"111",
			"100",
			"100"
		],
		[ //G
			"111",
			"100",
			"101",
			"101",
			"111"
		],
		[ //H
			"101",
			"101",
			"111",
			"101",
			"101"
		],
		[ //I
			"111",
			"010",
			"010",
			"010",
			"111"
		],
		[ //J
			"001",
			"001",
			"001",
			"101",
			"111"
		],
		[ //K
			"101",
			"101",
			"110",
			"101",
			"101"
		],
		[ //L
			"100",
			"100",
			"100",
			"100",
			"111"
		],
		[ //M
			"101",
			"111",
			"101",
			"101",
			"101"
		],
		[ //N
			"101",
			"111",
			"111",
			"111",
			"101"
		],
		[ //O
			"111",
			"101",
			"101",
			"101",
			"111"
		],
		[ //P
			"111",
			"101",
			"111",
			"100",
			"100"
		],
		[ //Q
			"111",
			"101",
			"111",
			"001",
			"001"
		],
		[ //R
			"110",
			"101",
			"110",
			"101",
			"101"
		],
		[ //S
			"111",
			"100",
			"111",
			"001",
			"111"
		],
		[ //T
			"111",
			"010",
			"010",
			"010",
			"010"
		],
		[ //U
			"101",
			"101",
			"101",
			"101",
			"111"
		],
		[ //V
			"101",
			"101",
			"101",
			"101",
			"010"
		],
		[ //W
			"101",
			"101",
			"101",
			"111",
			"101"
		],
		[ //X
			"101",
			"101",
			"010",
			"101",
			"101"
		],
		[ //Y
			"101",
			"101",
			"010",
			"010",
			"010"
		],
		[ //Z
			"111",
			"001",
			"010",
			"100",
			"111"
		],
	];

	var score=0;
	var alphamap = [
      "a"=>Key.A,
      "b"=>Key.B,
      "c"=>Key.C,
      "d"=>Key.D,
      "e"=>Key.E,
      "f"=>Key.F,
      "g"=>Key.G,
      "h"=>Key.H,
      "i"=>Key.I,
      "j"=>Key.J,
      "k"=>Key.K,
      "l"=>Key.L,
      "m"=>Key.M,
      "n"=>Key.N,
      "o"=>Key.O,
      "p"=>Key.P,
      "q"=>Key.Q,
      "r"=>Key.R,
      "s"=>Key.S,
      "t"=>Key.T,
      "u"=>Key.U,
      "v"=>Key.V,
      "w"=>Key.W,
      "x"=>Key.X,
      "y"=>Key.Y,
      "z"=>Key.Z
    ];

	var alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];

	var dat = [
	[0,0,0],
	[0,0,0],
	[0,0,0],
	[0,0,0],
	[0,0,0],
	];

	var removed = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
	var disabled = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

	function clearCanvas(){
		for (i in 0...3){
			for (j in 0...5){
				dat[j][i]=0;
			}
		}
		for (i in 0...26 ){
			disabled[i]=0;
		}
	}

	function drawCanvas(s:String){
		var si = alphabet.indexOf(s);
		disabled[si]=1;
		for (i in 0...3){
			for (j in 0...5){
				var p = Std.parseInt(charmasks[si][j].charAt(i));
				if (p>0){
					dat[j][i]=1-dat[j][i];
				}
			}
		}
		checkRemoved();
		Gfx.drawtoscreen();
	}

	function checkRemoved(){
		for (k in 0...26){
			if (disabled[k]==1||removed[k]==1){
				continue;
			}
			var toCompare = charmasks[k];			
			var allEqual=true;
			for (i in 0...3){
				for (j in 0...5){
					var p = Std.parseInt(toCompare[j].charAt(i));
					var q = dat[j][i];
					if (p!=q){
						allEqual=false;
						break;
					} 
				}
			}
			if (allEqual){
				removed[k]=1;
				score++;
			}
		}
	}
	function update(){

		var topMargin = 25;
		var leftMargin = 5;
		var columnHeight = 8;

	  	var x = leftMargin;
	  	var y = topMargin;


		function label(str){		
		  	Text.display(x,y+2,str,textCol);
		  	x += twi(str)+2;		  	
		}
	  	

	  	
	  	function newline(){
	  		x=leftMargin;
	  		y+=columnHeight;
	  	}

	  	function hgap(){
	  		x+=3;	  		
	  	}

	  	function hr(){
	  		y++;
		  	Gfx.fillbox(0,y,Gfx.screenwidth,1,recessedBackgroundCol);	 
			y+=2;
	  	}
	  	Gfx.clearscreen(backgroundCol);
	  	
	  	Gfx.fillbox(0,0,Gfx.screenwidth,13,recessedBackgroundCol);	 

	  	Text.wordwrap=Gfx.screenwidth;
	  	Text.display(1,1,"MAKE LETTERS FROM OTHER LETTERS");
	  	Text.wordwrap=0;


	  	Gfx.fillbox(Gfx.screenwidth/2-4,14,8,12,buttonCol);
	  	Gfx.fillbox(Gfx.screenwidth/2-4+1,14+1,6,10,Col.BLACK);

	  	for (i in 0...3){
	  		for (j in 0...5){
	  			var p = dat[j][i];
	  			if (p==1){
	  				var ox = Gfx.screenwidth/2-4+1;
	  				var oy = 14+1;
	  				var px = ox+i*2;
	  				var py = oy+j*2;
	  				Gfx.fillbox(px,py,2,2,Col.WHITE);
	  			}
	  		}
	  	}
	  	y++;
	  	hr();

	
	  	for (j in 0...6){	
	  		for (i in 0...6){
	  			var k = i+j*6;

	  			if (removed[k]==1){
					drawSmallButton(alphabet[i+j*6],x,y,Col.BLACK,backgroundCol,backgroundCol);
	  				x+=10;
	  				continue;
	  			}
	  			if (disabled[k]==1){
					drawSmallButton(alphabet[i+j*6],x,y,buttonCol,backgroundCol,backgroundCol);
	  				x+=10;
	  				continue;
	  			}
	  			if (k>=alphabet.length){
	  				break;
	  			}	  	 			
	  			if (drawSmallButton(alphabet[i+j*6],x,y,textCol,buttonCol,buttonHighlightCol)){
	  				drawCanvas(alphabet[i+j*6]);
	  			}
	  			x+=10;
			}
	  		var l = j*6;
			if (l>=alphabet.length){
  				break;
  			}	  	 			
	  		newline();
	  	}	 
	  	
	  	x=25;
	  	y-=columnHeight;
	  	if (drawButton(" reset ",x,y,textCol,buttonCol,buttonHighlightCol)
	  		||Input.justpressed(BACKSPACE)
	  		||Input.justpressed(ENTER)
	  		||Input.justpressed(DELETE)
	  			){
	  		clearCanvas();
	  	}	
		
		newline();
		y--;
		hr();
		
		Text.display(Text.CENTER,y,"score "+score,textCol);

		y+=5;
		hr();	


	  	Text.wordwrap=Gfx.screenwidth;
		Text.display(1,y,"by increpare + noa hoffmann",Col.BLACK);
	  	Text.wordwrap=0;

	}

}