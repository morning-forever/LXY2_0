var locat = (window.location+'').split('/'); 
$(function(){if('main'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

function exit(){
}

function message(){
	alert("功能待开发")
}

function agreement(){
	alert("agreement")
}

function appDownload(){
	alert("功能待开发")
}