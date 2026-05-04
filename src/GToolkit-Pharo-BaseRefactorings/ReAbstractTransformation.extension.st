Extension { #name : #ReAbstractTransformation }

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
ReAbstractTransformation >> applicabilityPreconditionsFor: aCollection [
	^ self
		forPharo13AndNewer: [ aCollection ]
		forOlder: [ aCollection inject: RBCondition true into: [ :sum :each | sum & each ] ]
]

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
ReAbstractTransformation >> primitiveExecute [
	<gtPharoPatch: #Pharo>
	
	^ self 
		forPharo12AndNewer: [self generateChanges] 
		forPharo11: [Error signal] 
]

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
ReAbstractTransformation >> refactoringError: aString with: aBlock [
	<gtPharoPatch: #Pharo>
	
	^ RBRefactoringError new 
			messageText: aString;
			signal	
]

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
ReAbstractTransformation >> refactoringFailure: aString [
	<gtPharoPatch: #Pharo>
	
	^ self 
		forPharo12AndNewer: [self refactoringError: aString] 
		forPharo11: [Error signal] 
]
