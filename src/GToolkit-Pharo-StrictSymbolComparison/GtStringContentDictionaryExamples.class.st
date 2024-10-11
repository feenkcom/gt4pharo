Class {
	#name : #GtStringContentDictionaryExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Examples'
}

{ #category : #examples }
GtStringContentDictionaryExamples >> sameStringContent [
	<gtExample>
	| dictionary |

	dictionary := GtStringContentDictionary new.
	dictionary
		at: #a put: 1;
		at: 'a' put: 2.
	self assert: dictionary size equals: 1.
	self assert: (dictionary at: #a) equals: 2.
]
