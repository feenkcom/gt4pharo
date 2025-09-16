Extension { #name : #RPackage }

{ #category : #'*GToolkit-Pharo-Metamodels' }
RPackage >> gtDoesExtendClasses [
	"Return true if I extend any class or metaclass"
	<return: #Boolean>

	^ self 
		forPharo12AndNewer: [
			"Pharo 12 has only a single slot 'extensionSelectors', while Pharo 11 has
			two distict slots for class and metaclass extensions"
			self extensionSelectors notEmpty ] 
		forPharo11: [
			self classExtensionSelectors isNotEmpty or: [ 
			self metaclassExtensionSelectors isNotEmpty ] ]
]
