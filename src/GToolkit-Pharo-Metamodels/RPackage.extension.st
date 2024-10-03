Extension { #name : #RPackage }

{ #category : #'*GToolkit-Pharo-Metamodels' }
RPackage >> gtDoesExtendClasses [
	"Return true if I extend any class or metaclass"
	<return: #Boolean>

	^ classExtensionSelectors isNotEmpty or: [ metaclassExtensionSelectors isNotEmpty ]
]
