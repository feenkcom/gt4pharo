Class {
	#name : #GtDefineTemporaryFixitActionExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Fixit'
}

{ #category : #examples }
GtDefineTemporaryFixitActionExamples >> complexInnerScopes [
	<gtExample>
	| code |
	code := 
'foo
	| a |
	a := 5.
	[ b := 3 ] value.
	[ b := 5 ] value.
	a := 7'.
	^RBParser parseMethod: code
]

{ #category : #examples }
GtDefineTemporaryFixitActionExamples >> complexInnerScopesFixit [
	<gtExample>
	| tree |
	tree := self complexInnerScopes.
	GtDefineTemporaryFixItAction new addDefinitionForTempAtOffset: 43 in: tree.
	self assert: tree body temporaryNames asArray equals: #('a' 'b').
	self
		assert: (tree body statements at: 2) receiver body temporaryNames asArray
		equals: #().
			self
		assert: (tree body statements at: 3) receiver body temporaryNames asArray
		equals: #().
	^ tree
]

{ #category : #examples }
GtDefineTemporaryFixitActionExamples >> complexInnerScopesFixit2 [
	<gtExample>
	| tree |
	tree := self complexInnerScopes.
	GtDefineTemporaryFixItAction new addDefinitionForTempAtOffset: 24 in: tree.
	self assert: tree body temporaryNames asArray equals: #('a' 'b').
	self
		assert: (tree body statements at: 2) receiver body temporaryNames asArray
		equals: #().
			self
		assert: (tree body statements at: 3) receiver body temporaryNames asArray
		equals: #().
	^ tree
]

{ #category : #examples }
GtDefineTemporaryFixitActionExamples >> complexNestedInnerScopes [
	<gtExample>
	| code |
	code := 
'foo
	| a |
	a := 5.
	[
		[ b := 3 ] value.
		[ b := 5 ] value.
	] value.
	a := 7'.
	^RBParser parseMethod: code
]

{ #category : #examples }
GtDefineTemporaryFixitActionExamples >> complexNestedInnerScopesFixit [
	<gtExample>
	| tree |
	tree := self complexNestedInnerScopes.
	GtDefineTemporaryFixItAction new addDefinitionForTempAtOffset: 48 in: tree.
	self assert: tree body temporaryNames asArray equals: #('a').
	self
		assert: (tree body statements at: 2) receiver body temporaryNames asArray
		equals: #('b').
	^ tree
]

{ #category : #examples }
GtDefineTemporaryFixitActionExamples >> multipleTopLevel [
	<gtExample>
	| code |
	code := 
'foo
	| b |
	a := 5.
	b := 6.
	a := a + b'.
	
	^RBParser parseMethod: code
]

{ #category : #examples }
GtDefineTemporaryFixitActionExamples >> multipleTopLevelFixit [
	<gtExample>
	| tree |
	tree := self multipleTopLevel.
	GtDefineTemporaryFixItAction new addDefinitionForTempAtOffset: 31 in: tree.
	self assert: tree body temporaryNames asArray equals: #('b' 'a').
	^tree
]

{ #category : #examples }
GtDefineTemporaryFixitActionExamples >> multipleTopLevelFixit2 [
	<gtExample>
	| tree |
	tree := self multipleTopLevel.
	GtDefineTemporaryFixItAction new addDefinitionForTempAtOffset: 36 in: tree.
	self assert: tree body temporaryNames asArray equals: #('b' 'a').
	^tree
]

{ #category : #examples }
GtDefineTemporaryFixitActionExamples >> simpleInnerLevel [
	<gtExample>
	| code |
	code := 
'foo
	| a |
	a := 5.
	[ b := 3 ] value.
	a := 7'.
	^RBParser parseMethod: code
]

{ #category : #examples }
GtDefineTemporaryFixitActionExamples >> simpleInnerLevelFixit [
	<gtExample>
	| tree |
	tree := self simpleInnerLevel.
	GtDefineTemporaryFixItAction new addDefinitionForTempAtOffset: 24 in: tree.
	self assert: tree body temporaryNames asArray equals: #('a').
	self
		assert: (tree body statements at: 2) receiver body temporaryNames asArray
		equals: #('b').
	^ tree
]

{ #category : #examples }
GtDefineTemporaryFixitActionExamples >> simpleTopLevel [
	<gtExample>
	| code |
	code := 
'foo
	a := 5'.
	
	^RBParser parseMethod: code
]

{ #category : #examples }
GtDefineTemporaryFixitActionExamples >> simpleTopLevelFixit [
	<gtExample>
	| tree |
	tree := self simpleTopLevel.
	GtDefineTemporaryFixItAction new addDefinitionForTempAtOffset: 6 in: tree.
	self assert: tree body temporaryNames asArray equals: #('a').
	^tree
]
