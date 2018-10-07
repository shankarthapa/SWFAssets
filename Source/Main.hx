package;

import openfl.display.*;
import openfl.text.*;
import openfl.geom.*;
import openfl.events.*;
import openfl.Assets;
import openfl.display.MovieClip;

class Main extends Sprite {
	private var clip:MovieClip;
	private var btnHolder:MovieClip;
	private var playerHolder:MovieClip;
	private var playerNormal:MovieClip;

	private var STAGE_WIDTH = 0;
	private var STAGE_HEIGHT = 0;

	private var frameCount = 1;
	

	public function new() {
		super();
		this.cacheAsBitmap = true;
		STAGE_WIDTH = this.stage.stageWidth;
		STAGE_HEIGHT = this.stage.stageHeight;
		init();
	}

	private function init(){
		renderBg();
		generateButtons();
		
		Assets.loadLibrary("femaleplayer").onComplete(function(value) {
			clip = getMovieClip("femaleplayer:Lady");
			playerHolder.addChild(clip);
		});
	}

	private function getMovieClip(str){
		var mc = Assets.getMovieClip(str);
		mc.scaleY = mc.scaleX = 2.5;
		mc.x = (STAGE_WIDTH - mc.width) / 2;
		mc.y = (STAGE_HEIGHT - mc.height) / 2;
		mc.cacheAsBitmap = true;
		return mc;
	}

	private function clickToPlay(evt){
		playerNormal = null;
		playerNormal = getMovieClip('femaleplayer:playerNormal'+frameCount);

		while(playerHolder.numChildren > 0){
			playerHolder.removeChildAt(0);
		}
		
		playerHolder.addChild(playerNormal);
		playerNormal.gotoAndPlay(2);
		trace(' crur  '+frameCount);
	}

	private function removeAndAddChild(){
		while(playerHolder.numChildren > 0){
			playerHolder.removeChildAt(0);
		}
		clip = null;
		clip = getMovieClip("femaleplayer:Lady");
		playerHolder.addChild(clip);
	}

	private function clickNextFrame(evt){
		removeAndAddChild();

		frameCount++;
		if(frameCount >= 8){
			frameCount = 8;
		}
		clip.gotoAndStop(frameCount);
	}

	private function clickPrevFrame(evt){
		removeAndAddChild();

		frameCount--;
		if(frameCount <= 0){
			frameCount = 0;
		}
		clip.gotoAndStop(frameCount);
	}

	private function clickToStop(evt){
		if(playerNormal != null) playerNormal.gotoAndStop(0);
	}

	private function generateButtons(){
		btnHolder = new MovieClip();
		btnHolder.graphics.beginFill(0x777777, .2);
		btnHolder.graphics.drawRect(0, 0, STAGE_WIDTH, 30);
		btnHolder.graphics.endFill();
		addChild(btnHolder);

		var btnPrev = getButton('Prev', clickPrevFrame);
		var btnPlay = getButton('Play', clickToPlay);
		var btnStop = getButton('Stop', clickToStop);
		var btnNext = getButton('Next', clickNextFrame);

		var btnList = new Array();
		var btnListMC = new MovieClip();
		btnList.push(btnPrev);
		btnList.push(btnPlay);
		btnList.push(btnStop);
		btnList.push(btnNext);
		

		var count = 0;
		for(item in btnList) {
			
			if(count== 0){
				item.x = 0;
			}else{
				item.x = btnList[ count-1 ].x + btnList[ count-1 ].width + 10;
			}

			btnListMC.addChild( item );
			count++;
		}

		btnListMC.x = (btnHolder.width - btnListMC.width) /2;
		btnHolder.addChild(btnListMC);
		
		
	}

	private function renderBg(){
		var bgMc = new MovieClip();
		var maxtrx = new Matrix();
		maxtrx.createGradientBox(STAGE_WIDTH, STAGE_HEIGHT, 0, 0, 1);
		maxtrx.rotate((Math.PI/180)*90);
		bgMc.graphics.beginGradientFill('linear',[0x000080, 0x0000FF], [.8, 1], [0, 255], maxtrx, SpreadMethod.PAD, InterpolationMethod.LINEAR_RGB, 1);
		bgMc.graphics.drawRect(0, 0, STAGE_WIDTH, STAGE_HEIGHT);
		bgMc.graphics.endFill();
		addChild(bgMc);

		playerHolder = new MovieClip();
		addChild(playerHolder);
	}

	private function getButton(str, callBack){
		var padding = 20;
		var myFormat:TextFormat = new TextFormat();
		myFormat.size = 15;

		var txt = new TextField();
		txt.text = str;
		txt.defaultTextFormat = myFormat;
		txt.width = txt.textWidth;
		txt.height = txt.textHeight;

		var container = new MovieClip();
		container.graphics.beginFill(0xcccccc, 1);
		container.graphics.drawRoundRect(0, 0, (txt.textWidth + padding), 30, 5);
		container.graphics.endFill();

		txt.x = (container.width - txt.textWidth)/2;
		txt.y = (container.height - txt.textHeight)/2;
		container.addChild(txt);
		container.buttonMode = true;
		container.addEventListener(MouseEvent.CLICK, callBack);
		return container;
	}
}
