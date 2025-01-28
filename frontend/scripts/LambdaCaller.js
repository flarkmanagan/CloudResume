const apiGatewayURL = "<API_GATEWAY_URL>"
//test111
fetch(apiGatewayURL) /*'https://uklka6v4r1.execute-api.eu-west-1.amazonaws.com/VisitorCounterUpdater' */
.then(data => {
return data.json();
})
.then(post => {
console.log(post.visitorCount);
document.getElementById("hitCounter").innerHTML = post.visitorCount;
});