Extension { #name : #RePullUpMethodRefactoring }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RePullUpMethodRefactoring >> gtDefaultToRemoveDuplicates [
	self 
		forPharo13AndNewer: [ "removeDuplicates was removed in Pharo 13"] 
		forOlder: [ super gtDefaultToRemoveDuplicates ]
]
