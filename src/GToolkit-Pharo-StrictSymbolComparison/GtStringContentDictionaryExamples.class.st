Class {
	#name : #GtStringContentDictionaryExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Examples'
}

{ #category : #examples }
GtStringContentDictionaryExamples >> orderedDictionaryRemovesKeyOfOtherKind [
	"A GtStringContentOrderedDictionary removes and replaces a key given with the other kind (String or Symbol), as it finds it for #at:,
	one key at a time, several at once (#removeKeys:), and the last key"

	<gtExample>
	<return: #GtStringContentOrderedDictionary>
	| dictionary |
	dictionary := GtStringContentOrderedDictionary new.
	dictionary
		at: 'title' put: 1;
		at: 'b' put: 2;
		at: #c put: 3.
	dictionary removeKey: #title.
	self assert: dictionary keys asArray equals: #('b' #c).
	self assert: (dictionary indexOfKey: #b ifAbsent: [ 0 ]) equals: 1.
	dictionary replaceKey: 'c' with: #d.
	self assert: dictionary keys asArray equals: #('b' #d).
	dictionary removeKey: 'd' ifAbsent: [ self error: 'the key d is present' ].
	self assert: dictionary keys asArray equals: #('b').
	self assert: (dictionary removeKey: #missing ifAbsent: [ #absent ]) equals: #absent.
	dictionary
		at: 'e' put: 5;
		at: #f put: 6;
		at: 'g' put: 7.
	dictionary removeKeys: #(#e 'f').
	self assert: dictionary keys asArray equals: #('b' 'g').
	dictionary removeKeys: #(#g).
	self assert: dictionary keys asArray equals: #('b').
	dictionary removeKey: #b.
	self assert: dictionary isEmpty.
	^ dictionary
]

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
