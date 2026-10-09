Extension { #name : #ReAbstractTransformation }

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
ReAbstractTransformation >> primitiveExecute [
	<gtPharoPatch: #Pharo>
	
	^ self generateChanges
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
	
	^ self refactoringError: aString
]
