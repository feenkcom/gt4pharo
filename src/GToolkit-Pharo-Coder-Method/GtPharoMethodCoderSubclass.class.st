Class {
	#name : #GtPharoMethodCoderSubclass,
	#superclass : #GtPharoMethodCoder,
	#instVars : [
		'testClassName'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #'instance creation' }
GtPharoMethodCoderSubclass class >> forMethod: aCompiledMethod className: aSymbol [

	^ self new
		forMethod: aCompiledMethod;
		testClassName: aSymbol.
]

{ #category : #accessing }
GtPharoMethodCoderSubclass >> testCase [
	<return: #GtPharoMethodTestCase or: nil>

	^ self
		attributeNamed: #testCase
		ifPresent: [ :aTestCase | aTestCase ]
		ifAbsent: [ self compiledMethod ifNotNil: [ :theMethod |
			(GtPharoTestCaseUtility canExecuteTestCase: theMethod) ifFalse: [ ^ nil ].
			self attributeNamed: #testCase put: (GtPharoMethodTestCaseSubclass
				forMethod: theMethod
				className: testClassName) ] ]
]

{ #category : #accessing }
GtPharoMethodCoderSubclass >> testClassName [
	^ testClassName
]

{ #category : #accessing }
GtPharoMethodCoderSubclass >> testClassName: anObject [
	testClassName := anObject
]
