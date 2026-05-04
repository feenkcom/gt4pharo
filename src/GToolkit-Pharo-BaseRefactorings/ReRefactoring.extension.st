Extension { #name : #ReRefactoring }

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
ReRefactoring >> applicabilityPreconditionsFor: aCollection [
	^ self
		forPharo13AndNewer: [ aCollection ]
		forOlder: [ aCollection inject: RBCondition true into: [ :sum :each | sum & each ] ]
]
