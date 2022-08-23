Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Pharo-Coder-Method' }
CompiledMethod >> gtPharoMethodTestCase [
	<return: #GtPharoMethodTestCase or: nil>
	| aWeak aPharoMethodTestCase |
	(GtPharoTestCaseUtility canExecuteTestCase: self) ifFalse: [ ^ nil ].

	aWeak := self propertyAt: #gtPharoMethodTestCaseWeakReference ifAbsent: [ nil ].
	aWeak
		ifNotNil: [ :theWeak | 
			(theWeak at: 1 ifAbsent: [ nil ])
				ifNotNil: [ :aCachedPharoMethodTestCase | ^ aCachedPharoMethodTestCase ] ].

	aPharoMethodTestCase := GtPharoMethodTestCase forMethod: self.
	self
		propertyAt: #gtPharoMethodTestCaseWeakReference
		put: aPharoMethodTestCase asWeakReference.
	^ aPharoMethodTestCase
]
