"
GtPharoMethodTestCaseSubclass extends {{gtClass:GtPharoMethodTestCase}} to specify the class in which the test should be run, allowing a superclass method to be edited, but only execute the test in the selected class.
"
Class {
	#name : #GtPharoMethodTestCaseSubclass,
	#superclass : #GtPharoMethodTestCase,
	#instVars : [
		'testClassName'
	],
	#category : 'GToolkit-Pharo-TestSuite-Base'
}

{ #category : #'instance creation' }
GtPharoMethodTestCaseSubclass class >> forMethod: aCompiledMethod className: aSymbol [

	^ self new
		method: aCompiledMethod;
		testClassName: aSymbol
]

{ #category : #accessing }
GtPharoMethodTestCaseSubclass >> behavior [

	^ self class environment classOrTraitNamed: testClassName.
]

{ #category : #accessing }
GtPharoMethodTestCaseSubclass >> testClassName [
	^ testClassName
]

{ #category : #accessing }
GtPharoMethodTestCaseSubclass >> testClassName: anObject [
	testClassName := anObject
]
