describe('API Test', () => {
  const invokeUrl = '<API_GATEWAY_URL>';

  it('Return visit count and 200 response code', () => {
    cy.request({
      method: 'GET',
      url: invokeUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    }).then((response) => {
      console.log(response.headers['content-type']);
      expect(response.status).to.eq(200);
      const responseBody = typeof response.body === 'string' ? JSON.parse(response.body) : response.body;
      expect(responseBody).to.have.property('visitorCount');
      expect(responseBody.visitorCount).to.be.a('number');
      expect(responseBody.visitorCount).to.be.greaterThan(0);
    });
  });
});
