describe "The primers module", ->
    $controller = {}
    $httpB = {}
    $location = {}
    $scope = {}

    Primer = {}

    beforeEach ->
        module "primers"

    # Inject all of our dependencies here, to share across test cases.
    # `beforeEach` will ensure that a new injection is done before each test.
    # We like to do this to keep test cases brief and free of cruft.
    beforeEach inject(($injector) ->
        $controller = $injector.get "$controller"
        $httpB = $injector.get "$httpBackend"
        $location = $injector.get "$location"
        $scope = $injector.get("$rootScope").$new

        Primer = $injector.get "Primer"
    )

    # These verifications will fail if any HTTP requests are still pending.
    # We need to make sure that all requests have completed to finish the tests.
    # `$httpB.flush()` should take care of this, so you should never actually
    # have to deal with this.
    afterEach ->
        $httpB.verifyNoOutstandingExpectation()
        $httpB.verifyNoOutstandingRequest()

    it "generates a Primer resource", ->
        assert.equal Primer.name, "Resource"
        assert.isFunction Primer.query
        assert.isFunction new Primer().$save

    it "has a list controller that fetches primers", inject ->
        $httpB.expectGET("primers").respond(["primer 1", "primer 2"])
        $controller("PrimerListController", $scope: $scope)

        $httpB.flush()
        
        assert.equal $scope.primers[0], "primer 1"
        assert.equal $scope.primers[1], "primer 2"

    it "has a detail controller that fetches primer details and saves", ->
        # Fetch
        $httpB.expectGET("primers/123abc").respond({ id: "123abc", name: "GFP FP", code: "A01" })
        $controller("PrimerDetailController",
            $scope: $scope,
            $routeParams: { id: "123abc" })

        $httpB.flush()
        
        assert.equal $scope.primer.name, "GFP FP"
        assert.equal $scope.primer.code, "A01"
        assert.equal $scope.primer.id, "123abc"

        # Save
        $httpB.expectPUT("primers/123abc").respond({ name: "BFP RP", code: "B01" })
        $scope.primer.name = "BFP RP"
        $scope.primer.code = "B01"
        $scope.save()

        $httpB.flush()

        assert.equal $scope.primer.name, "BFP RP"
        assert.equal $scope.primer.code, "B01"

    it "has a new controller that creates a new primer", ->
        # We expect no id in the URL because it is assigned on the first save
        # by the server.
        $httpB.expectPOST("primers").respond({ name: "GFP FP", code: "A01" })
        
        $controller("NewPrimerController", $scope: $scope)
        $scope.primer.name = "GFP FP"
        $scope.primer.code = "A01"
        $scope.primer.sequence = "acgtacgt"
        $scope.save()

        $httpB.flush()
        
        assert.equal $scope.primer.name, "GFP FP"
        assert.equal $scope.primer.code, "A01"
        assert.equal $location.path(), "/primers"

    it "allows deleting primers from the detail controller", ->
        $httpB.expectGET("primers/123abc").respond({ id: "123abc", name: "GFP FP", code: "A01" })

        $controller("PrimerDetailController",
            $scope: $scope,
            $routeParams: { id: "123abc" })

        $httpB.flush()
        assert.equal $scope.primer.name, "GFP FP"

        # Delete
        $httpB.expectDELETE("primers/123abc").respond({ name: "GFP FP", code: "A01" })
        $scope.delete()
        $httpB.flush()
