fetch('https://f9fm79pz96.execute-api.eu-west-1.amazonaws.com/prod/update-count')
.then(data => {
return data.json();
})
.then(post => {
console.log(post.visitorCount);
document.getElementById("hitCounter").innerHTML = post.visitorCount;
});
