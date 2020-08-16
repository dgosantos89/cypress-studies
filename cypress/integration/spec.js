/// <reference types="Cypress" />

describe("Google Search", function(){
    it("Find Gherkin", function(){
        cy.visit("http://www.google.com")
        cy.get('.gLFyf')
        .type('Gherkin')
        .type('{enter}')
        cy.contains('dgosantos89.github.io')
    })
})