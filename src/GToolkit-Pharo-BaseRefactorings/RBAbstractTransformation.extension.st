Extension { #name : #RBAbstractTransformation }

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBAbstractTransformation >> isValidSelector: aString [
	<gtPharoPatch: #Pharo13>
	
	"Returns the boolean true if aString is a valid selector (name of method).
	 For checking if there is symbol like me used as a selector, see Symbol>>#isSelectorSymbol"

	"Pay attention RBCondition >> #isValidSelector is returning an Condition object."
	^ self 
			forPharo13AndNewer: [#OCScanner asClass isSelector: aString] 
			forOlder: [self checkMethodName: aString in: nil ]
]

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBAbstractTransformation >> primitiveExecute [
	<gtPharoPatch: #Pharo>
	
	^ self 
		forPharo12AndNewer: [self generateChanges] 
		forPharo11: [Error signal] 
]

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBAbstractTransformation >> refactoringError: aString with: aBlock [
	<gtPharoPatch: #Pharo>
	
	^ RBRefactoringError new 
			messageText: aString;
			signal	
]

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBAbstractTransformation >> refactoringFailure: aString [
	<gtPharoPatch: #Pharo>
	
	^ self 
		forPharo12AndNewer: [self refactoringError: aString] 
		forPharo11: [Error signal] 
]
