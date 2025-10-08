Class {
	#name : #GtCreateSnippetSourceFromMethodExamples,
	#superclass : #Object,
	#instVars : [
		'someVar'
	],
	#category : #'GToolkit-Pharo-Coder-Examples-Refactorings - Support'
}

{ #category : #'test methods' }
GtCreateSnippetSourceFromMethodExamples class >> test0 [
	^ self isClassSide
]

{ #category : #examples }
GtCreateSnippetSourceFromMethodExamples >> inlineClassSide [
	<gtExample>
	| source |
	source := GtCreateSnippetSourceFromMethod new
			method: self class class >> #test0;
			generate.
	self
		assert: (RBParser parseExpression: source)
		equals: (RBParser
				parseExpression: 'GtCreateSnippetSourceFromMethodExamples
	== GtCreateSnippetSourceFromMethodExamples class').
	^ source
]

{ #category : #examples }
GtCreateSnippetSourceFromMethodExamples >> inlineTestMessages [
	<gtExample>
	| source |
	source := GtCreateSnippetSourceFromMethod new
			method: self class >> #test0;
			selectorsNotToInline: #(printString);
			generate.
	self
		assert: (RBParser parseExpression: source)
		equals: (RBParser
				parseExpression: 'instance := ' , self class name
						, ' new. self assert: instance class name size > 2. var := instance printString size. var + (instance instVarNamed: ''someVar'') + instance printString size').
	^ source
]

{ #category : #examples }
GtCreateSnippetSourceFromMethodExamples >> noInlining [
	<gtExample>
	| source |
	source := GtCreateSnippetSourceFromMethod new
			method: self class >> #test0;
			inlineSelfSends: false;
			generate.
	self
		assert: (RBParser parseExpression: source)
		equals: (RBParser
				parseExpression: 'instance := ' , self class name , ' new. instance test1 + instance test2').
	^ source
]

{ #category : #examples }
GtCreateSnippetSourceFromMethodExamples >> partialInline [
	<gtExample>
	| source |
	source := GtCreateSnippetSourceFromMethod new
			method: self class >> #test0;
			selectorsNotToInline: #(test2 test4);
			generate.
	self
		assert: (RBParser parseExpression: source)
		equals: (RBParser
				parseExpression: 'instance := ' , self class name
						, ' new. self assert: instance class name size > 2. var := instance test2. var + instance test4 + instance test2').
	^ source
]

{ #category : #'test methods' }
GtCreateSnippetSourceFromMethodExamples >> test0 [
	^ self test1 + self test2
]

{ #category : #'test methods' }
GtCreateSnippetSourceFromMethodExamples >> test1 [
	| var |
	var := self test3.
	^ var + self test4
]

{ #category : #'test methods' }
GtCreateSnippetSourceFromMethodExamples >> test2 [
	^ self printString size
]

{ #category : #'test methods' }
GtCreateSnippetSourceFromMethodExamples >> test3 [
	self assert: self text7 > 2.
	^ self test2
]

{ #category : #'test methods' }
GtCreateSnippetSourceFromMethodExamples >> test4 [
	^ someVar
]

{ #category : #'test methods' }
GtCreateSnippetSourceFromMethodExamples >> text7 [
	^ self class name size
]
