"
I am a {{gtClass:GtPharoMethodTestCaseState}} visitor.
"
Trait {
	#name : #TGtPharoMethodTestCaseStateVisitor,
	#category : #'GToolkit-Pharo-TestSuite-States'
}

{ #category : #visiting }
TGtPharoMethodTestCaseStateVisitor >> visitTestCaseErrorState: aState [
	^ self visitTestCaseUnsuccessfulState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseStateVisitor >> visitTestCaseExecutingState: aState [
	^ self visitTestCaseState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseStateVisitor >> visitTestCaseFailureState: aState [
	^ self visitTestCaseUnsuccessfulState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseStateVisitor >> visitTestCaseNotExecutableState: aState [
	^ self visitTestCaseState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseStateVisitor >> visitTestCaseNotExecutedState: aState [
	^ self visitTestCaseState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseStateVisitor >> visitTestCasePassedState: aState [
	^ self visitTestCaseResultState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseStateVisitor >> visitTestCaseResultState: aState [
	^ self visitTestCaseState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseStateVisitor >> visitTestCaseSkippedState: aState [
	^ self visitTestCaseState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseStateVisitor >> visitTestCaseState: aState [
]

{ #category : #visiting }
TGtPharoMethodTestCaseStateVisitor >> visitTestCaseUncompletedState: aState [ 
	^self visitTestCaseErrorState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseStateVisitor >> visitTestCaseUnsuccessfulState: aState [ 
	^ self visitTestCaseResultState: aState
]
