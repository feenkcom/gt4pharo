Extension { #name : #Package }

{ #category : #'*GToolkit-Pharo-Metamodels' }
Package >> gtDoesExtendClasses [
	"Return true if I extend any class or metaclass"
	<return: #Boolean>

	^ self extensionSelectors notEmpty
]
