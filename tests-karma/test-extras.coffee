angular.module('core').constant('urlPrefix', '/urlPrefix')
angular.module('core').constant('ajentiPlugins', [])
angular.module('core').constant('ajentiVersion', 'testenv')
angular.module('core').constant('ajentiPlatform', 'test')
angular.module('core').constant('ajentiPlatformUnmapped', 'test')

for m in window.__ngModules
    beforeEach module(m)

window.__initHttpBackend = () ->
    inject ($httpBackend, urlPrefix)->
        if $httpBackend.oldWhen
            return

        $httpBackend.oldWhen = $httpBackend.when
        $httpBackend.when = (method, url) ->
            return $httpBackend.oldWhen(method, urlPrefix + url)

        for m in ['expectGET', 'expectPOST']
            do (m) ->
                $httpBackend['old' + m] = $httpBackend[m]
                $httpBackend[m] = (url) ->
                    return $httpBackend['old' + m](urlPrefix + url)



beforeEach () ->

beforeEach () ->
    __initHttpBackend()


afterEach () ->
    inject ($httpBackend) ->
        $httpBackend.verifyNoOutstandingExpectation()
        $httpBackend.verifyNoOutstandingRequest()


beforeEach () ->
    @sinon = sinon.sandbox.create()

afterEach () ->
    @sinon.restore()
