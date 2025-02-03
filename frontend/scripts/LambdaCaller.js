const apiGatewayURL = "<API_GATEWAY_URL>"
fetch(apiGatewayURL)
.then(data => {
return data.json();
})
.then(post => {
console.log(post.visitorCount);
document.getElementById("hitCounter").innerHTML = post.visitorCount;
});
