/*

To customize... 

set the variable svcUrl
set the default paramUrn

*/

var paramWidth; // the width as specified on in the request-parameters
var trueWidth; // an ROI might be specified on the command-line; this is the true width of the larger image
var trueHeight; // an ROI might be specified on the command-line; this is the true height of the larger image
var widthFactor, heightFactor, topOffset, leftOffset; // an ROI might be specified on the command-line; this is the width and height;
var paramUrn; // the URN requested, which might have an ROI
var requestedImageUrn; // this is the image-only part of the requested URN
var requestedImageRoi; // this is the ROI-only part of the requested URN
var usingDefaults = false;

paramWidth = get('w');
paramUrn = get('urn');


// defaults
if (paramWidth == undefined){
	paramWidth = 800;
	usingDefaults = true;
}

if (paramUrn == undefined){
	paramUrn = "urn:cite:fufolioimg:ChadRGB.Chad012";
	//paramUrn = "urn:cite:hmt:chsimg.VA001VN-0503";
	usingDefaults = true;
}

requestedImageUrn = plainUrn(paramUrn);
requestedImageRoi = urnRoi(paramUrn);

if (requestedImageRoi != ""){
	widthFactor = parseFloat(requestedImageRoi.split(",")[2]);
	heightFactor = parseFloat(requestedImageRoi.split(",")[3]);
	topOffset = parseFloat(requestedImageRoi.split(",")[1]); leftOffset = parseFloat(requestedImageRoi.split(",")[0]);
} else {
	widthFactor = 1; heightFactor = 1;
	topOffset = 0; leftOffset = 0;
	
}


// Adjust paramWidth and trueWidth according to whether an ROI is specified on the command-line
if (requestedImageRoi != ""){
	trueWidth = trueWidthFromRoi(requestedImageRoi, paramWidth);
} else {
	trueWidth = paramWidth;
}

var svcUrl = "http://amphoreus.hpcc.uh.edu/tomcat/chsimg/Img?";

var citeReq = svcUrl + "request=GetBinaryImage&w=" + trueWidth;
citeReq += "&urn=" + paramUrn;


var startX, startY, currentX, currentY, currentWidth, currentHeight;
var currentROI = "";
var imgDivHeight;

//get request parameter
function get(name){
   if(name=(new RegExp('[?&]'+encodeURIComponent(name)+'=([^&]*)')).exec(location.search))
      return decodeURIComponent(name[1]);
}

//Calculate trueWidth, given a whole-image width and an ROI
function trueWidthFromRoi(roi, pw){
	var tw = parseFloat(roi.split(",")[2]);
	return ( pw / tw);	
}

//Calculate trueHeight, given a whole-image width and an ROI
function trueHeightFromRoi(roi, ph){
	var th = parseFloat(roi.split(",")[3]);
	return ( ph / th);	
}



// return image-urn part of a URN+ROI
function plainUrn(wholeUrn){
	var tempArray = wholeUrn.split(":");
	var arrayLength = tempArray.length;
	var tempString = "";
	if (arrayLength > 4){
		tempString = tempArray[0] + ":" + tempArray[1] + ":" + tempArray[2] + ":" + tempArray[3];
		return tempString;
	} else {
		return wholeUrn;
	}
}

// return roi part of a URN+ROI
function urnRoi(wholeUrn){
	var tempArray = wholeUrn.split(":");
	var arrayLength = tempArray.length;
	var tempString = "";
	if (arrayLength > 4){
		tempString = tempArray[4];
		return tempString;
	} else {
		return "";
	}
}

function init(){

	if (usingDefaults){
		//window.location = "index.html?urn=" + paramUrn + "&w=" + paramWidth;
		window.location = "index.html?w=" + paramWidth + "&urn=" + paramUrn;
	} else {
		initInfo();
		var offset = $("#citeImage").offset()
		startX = offset.left;
		startY = offset.top;

		draw();
	}
}

function setSizes(iw, ih){
	$("#citeImage").attr("width",iw);
	$("#citeImage").attr("height",(ih));
}

function draw(){  
	var canvas = document.getElementById('citeImage'); 
	if (canvas.getContext){  
		var ctx = canvas.getContext('2d');  
		
		function drawImage(){
			ctx.strokeStyle = "rgba(256,256,0,0.75)";
			ctx.lineWidth = 1;
			ctx.clearRect(0,0,this.width,this.height);
			var img = new Image();
			img.src = citeReq;
			
			img.onload = function(){
				imgDivHeight = img.height;
				// at this point, we can set trueHeight
				if (requestedImageRoi != ""){
					trueHeight = trueHeightFromRoi(requestedImageRoi, imgDivHeight);
				} else {
					trueHeight = imgDivHeight;
				}
				 
				setSizes(img.width,img.height);
				ctx.drawImage(img,0,0);
			}

			
			
		}
		
		function lockRect(doneDrawing,x,y,width,height){
			ctx.strokeStyle = "rgba(256,256,0,0.75)";
			ctx.lineWidth = 2;
			ctx.clearRect(0,0,this.width,this.height);
			var img = new Image();
			img.src = citeReq;
			imgDivHeight = img.height;
			img.onload = function(){
				ctx.drawImage(img,0,0); 
				if (doneDrawing){
				 ctx.strokeRect(x, y, width, height);
				}				
			}
			
			
		}
		
		drawImage();
		
		// bind mouse events
        canvas.onmousemove = function(e) {
            if (!canvas.isDrawing) {
               return;
            }
			ctx.strokeStyle = "rgba(200,200,0,1)";
            currentX = e.pageX - this.offsetLeft;
            currentY = e.pageY - this.offsetTop;
            currentWidth = currentX - startX;
            currentHeight = currentY - startY;
            ctx.strokeRect(startX, startY, currentWidth, currentHeight);
        };
        canvas.onmousedown = function(e) {
            canvas.isDrawing = true;
			drawImage(false);
            startX = e.pageX - this.offsetLeft;
            startY = e.pageY - this.offsetTop;
        };
        canvas.onmouseup = function(e) {
            canvas.isDrawing = false;
            lockRect(true, startX, startY, currentWidth, currentHeight);
            
            updateROI(startX, startY, currentWidth, currentHeight);
        };
		

		
					
	} else {
		alert("Failed to get canvas, for some reason.");
	}
}  

function updateROI(x,y,cw,ch){
	// x and y = left and top
	// cw and ch = current-width and current height
	//wf and hf = division-factors when looking at a zoomed ROI
	// x and y might not be top and left! Deal with that first
	
	if (cw < 0){
		cw = Math.abs(cw);
		x = x-cw;
	}
	
	if (ch < 0) {
		ch = Math.abs(ch);
		y = y-ch;
	}

			
	var t = y / imgDivHeight;
	var l = x / paramWidth;
	var w = cw / paramWidth;
	var h = ch / imgDivHeight;

	// at this point we have local coordinates
	t = (t * heightFactor) + topOffset;
	l = (l * widthFactor) + leftOffset;
	w = w * widthFactor;
	h = h * heightFactor;
	
	
	//final rounding
	t = Math.round(t * 10000) / 10000;
	l = Math.round(l * 10000) / 10000;
	w = Math.round(w * 10000) / 10000;
	h = Math.round(h * 10000) / 10000;
	
/*
	var t = Math.round((y / imgDivHeight) * 1000)/1000;
	var l = Math.round((x / paramWidth) * 1000)/1000;
	var w = Math.round((cw / paramWidth) * 1000)/1000;
	var h = Math.round((ch / imgDivHeight) * 1000)/1000;

*/	
	
	currentROI = ":" + l + "," + t + "," + w + "," + h;
	
	initInfo();
}

function initInfo(){

	var biggerImg = parseInt(paramWidth) + 200;
	var smallerImg = parseInt(paramWidth) - 200;
	smallerImg = Math.max(smallerImg,200);
	biggerImg = Math.min(biggerImg,1200);
	var zoomedOutRoi = "";
	var roil, roit, roiw, roih;
	
	if (requestedImageRoi != ""){
		roil = parseFloat(requestedImageRoi.split(",")[0]) - 0.1;
		roit = parseFloat(requestedImageRoi.split(",")[1]) - 0.1;
		roiw = parseFloat(requestedImageRoi.split(",")[2]) + 0.1;
		roih = parseFloat(requestedImageRoi.split(",")[3]) + 0.1;
		roil = Math.max(roil,0);
		roit = Math.max(roit,0);
		roiw = Math.min((roiw + roil),1);
		roih = Math.min((roih + roit),1);
		roil = Math.round(roil * 10000) / 10000;
		roit = Math.round(roit * 10000) / 10000;
		roiw = Math.round(roiw * 10000) / 10000;
		roih = Math.round(roih * 10000) / 10000;
		zoomedOutRoi = ":" + roil + "," + roit + "," + roiw + "," + roih;
		if (zoomedOutRoi == ":0,0,1,1"){ zoomedOutRoi = ""; }
	}
	

	var tempText = "<h1><span ><a href='" + requestedImageUrn + currentROI + "'>Right-click here to copy URN.</a><span></h1>";
	tempText += "<ul class='generatedData'>";
	tempText += "<li>" + requestedImageUrn + currentROI  + "</li>";
	tempText += "<li>Service: " + svcUrl + "</li></ul>";
	tempText += "<ul class='generatedData'><li><a href='" + svcUrl + "&request=GetBinaryImage&urn=" + requestedImageUrn + currentROI + "&w=3000'>Test Link - Image Quotation</a></li>";
	tempText += "<li><a href='" + svcUrl + "&request=GetIIPMooViewer&urn=" + requestedImageUrn + currentROI + "'>Test Link - Image Quotation in Context</a></li>";	
	tempText += "</ul>";
	


	//tempText += "<h2>Zooming &amp; Resizing</h1>";
	tempText += "<ul class='generatedData'>";
	//tempText += "<li><em>Zoom Working View</em></li>";


	var tempTW = trueWidthFromRoi(currentROI, paramWidth);
	console.log("potentialWidth = " + tempTW);

	if ((tempTW > 0) && (tempTW <= 4000)){		
		tempText += "<li><a href='index.html?w=" + paramWidth + "&urn=" + requestedImageUrn + currentROI + "'>Zoom to selected rectangle</a></li>";
	}
	
	if (requestedImageRoi != ""){
		tempText += "<li><a href='index.html?w=" + paramWidth + "&urn=" + requestedImageUrn + zoomedOutRoi + "'>Zoom out a bit</a></li>";
		tempText += "<li><a href='index.html?w=" + paramWidth + "&urn=" + requestedImageUrn + "'>Zoom out to whole image</a></li>";
	}

	
	tempText += "<li><em>Resize View:</em>"; 
	tempText += "<a href='index.html?w=" + smallerImg + "&urn=" + paramUrn + "'> smaller</span></a></li>";
	
	if (trueWidth <= 4000){
		tempText += "<li><em>Resize View:</em><a href='index.html?w=" + biggerImg + "&urn=" + paramUrn + "'> larger</span></a></li>";
	}
	
	if (usingDefaults){
		tempText += "<li>Using default values for image-URN and image-width. <a href='index.html?w=" + paramWidth + "&urn=" + paramUrn + "'>Reload with request-parameters visible in the address-bar.</a></li>";
		
	}
		
	tempText += "</ul>";
	
	$("#info").html(tempText);
}
