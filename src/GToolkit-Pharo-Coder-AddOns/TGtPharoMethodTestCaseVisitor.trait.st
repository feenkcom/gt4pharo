"
I am a {{gtClass:GtPharoMethodTestCaseState}} visitor.
"
Trait {
	#name : #TGtPharoMethodTestCaseVisitor,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #visiting }
TGtPharoMethodTestCaseVisitor >> visitTestCaseErrorState: aState [
	^ self visitTestCaseUnsuccessfulState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseVisitor >> visitTestCaseFailureState: aState [
	^ self visitTestCaseUnsuccessfulState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseVisitor >> visitTestCaseNotExecutableState: aState [
	^ self visitTestCaseState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseVisitor >> visitTestCaseNotExecutedState: aState [
	^ self visitTestCaseState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseVisitor >> visitTestCasePassedState: aState [
	^ self visitTestCaseResultState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseVisitor >> visitTestCaseResultState: aState [
	^ self visitTestCaseState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseVisitor >> visitTestCaseSkippedState: aState [
	^ self visitTestCaseState: aState
]

{ #category : #visiting }
TGtPharoMethodTestCaseVisitor >> visitTestCaseState: aState [
]

{ #category : #visiting }
TGtPharoMethodTestCaseVisitor >> visitTestCaseUnsuccessfulState: aState [ 
	^ self visitTestCaseResultState: aState
]
