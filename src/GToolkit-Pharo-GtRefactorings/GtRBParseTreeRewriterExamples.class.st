Class {
	#name : #GtRBParseTreeRewriterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-GtRefactorings-Examples'
}

{ #category : #examples }
GtRBParseTreeRewriterExamples >> convertAtPutMethodToPutAt [
	<gtExample>
	| before after rewriter |
	before := 'at: anIndex put: anObject
				^collection at: anIndex put: anObject'.
	after := 'put: anObject at: anIndex
				^collection at: anIndex put: anObject'.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replaceMethod: 'at: `arg1 put: `arg2 | `@temps | `@.Stmts'
		with: 'put: `arg2 at: `arg1 | `@temps | `@.Stmts'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> convertColorIsOpaque [
	<gtExample>
	| before after rewriter |
	before := 'isOpaque
				^ element isOpaque | color isOpaque | self myColor isOpaque'.
	after := 'isOpaque
				^ element isOpaque | color isTranslucent not | self myColor isTranslucent not'.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: '`{:node :dict | dict at: ''receiver'' put: node. ''*color*'' match: node sourceCode} isOpaque'
		with: '`{:dict | (dict at: ''receiver'') copy} isTranslucent not'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> convertColorIsOpaqueAlternative [
	<gtExample>
	| before after rewriter |
	before := 'isOpaque
				^ element isOpaque | color isOpaque | self myColor isOpaque'.
	after := 'isOpaque
				^ element isOpaque | color isTranslucent not | self myColor isTranslucent not'.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: '``@node `{:node :dict | ''*color*'' match: node sourceCode} isOpaque'
		with: '``@node isTranslucent not'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> convertOnlyVariables [
	<gtExample>
	| before after rewriter |
	before := 'someMethod: anObject
					ProtoObject someInstance isNil ifTrue: [^1].
					anObject isNil ifTrue: [^2].
					^3'.
	after := 'someMethod: anObject
					ProtoObject someInstance isNil ifTrue: [^1].
					anObject ifNil: [^2].
					^3'.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: '`a isNil ifTrue: ``@b' with: '`a ifNil: ``@b'.	"A single ` character matches only variable nodes"
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> convertToIfNil [
	<gtExample>
	| before after rewriter |
	before := 'someMethod
					ProtoObject someInstance isNil ifTrue: [^self].
					Link someInstance notNil ifTrue: [^self].
					^#()'.
	after := 'someMethod
					ProtoObject someInstance ifNil: [^self].
					Link someInstance ifNotNil: [^self].
					^#()'.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: '`@a isNil ifTrue: `@b' with: '`@a ifNil: `@b'.
	rewriter replace: '`@a notNil ifTrue: `@b' with: '`@a ifNotNil: `@b'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> literalMatches [
	<gtExample>
	| before after rewriter |
	before := 'someMethod
					^{} class someInstance odd ifTrue: [1] ifFalse: [#(1)]'.
	after := 'someMethod
					^{} class someInstance odd ifTrue: [1 printString] ifFalse: [#(1) printString]'.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: '`#l' with: '`#l printString'.	"Adding the # character matches only literal characters."
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> nonRecursiveIfNil [
	<gtExample>
	| before after rewriter |
	before := 'someMethod
					ProtoObject someInstance isNil ifTrue: [Link someInstance isNil ifTrue: [^self]].
					^#()'.
	after := 'someMethod
					ProtoObject someInstance ifNil: [Link someInstance isNil ifTrue: [^self]].
					^#()'.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: '`@a isNil ifTrue: `@b' with: '`@a ifNil: `@b'.	"Only replace at the top most match and don't search for anything under that match."
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> recursiveIfNil [
	<gtExample>
	| before after rewriter |
	before := 'someMethod
					ProtoObject someInstance isNil ifTrue: [Link someInstance isNil ifTrue: [^self]].
					^#()'.
	after := 'someMethod
					ProtoObject someInstance ifNil: [Link someInstance ifNil: [^self]].
					^#()'.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: '``@a isNil ifTrue: ``@b' with: '``@a ifNil: ``@b'.	"Use a second ` character to search for more matches."
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> removeReturnSelf [
	<gtExample>
	| before after rewriter |
	before := 'at: anObject put: anotherObject
					(dictionary includesKey: anObject) ifTrue: [^self].
					dictionary at: anObject put: anotherObject.
					^self'.
	after := 'at: anObject put: anotherObject
					(dictionary includesKey: anObject) ifTrue: [].
					dictionary at: anObject put: anotherObject'.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: '| `@temps |
					``@.Stmts.
					^self'
		with: '| `@temps |
					``@.Stmts'.	"Converts any sequence node that has return self at the end"
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> removeUnnecessaryReturnSelf [
	<gtExample>
	| before after rewriter |
	before := 'at: anObject put: anotherObject
					(dictionary includesKey: anObject) ifTrue: [^self].
					dictionary at: anObject put: anotherObject.
					^self'.
	after := 'at: anObject put: anotherObject
					(dictionary includesKey: anObject) ifTrue: [^self].
					dictionary at: anObject put: anotherObject'.
	rewriter := RBParseTreeRewriter new.
	rewriter replaceMethod: '`@method: `@args
					| `@temps |
					`@.Stmts.
					^self' with: '`@method: `@args
					| `@temps |
					`@.Stmts'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> renameVariable [
	<gtExample>
	| before after rewriter |
	before := 'someMethod
				| var |
				var := 0.
				self printString do: [:each | each isVowel ifTrue: [var := var + 1]].
				^var'.
	after := 'someMethod
				| count |
				count := 0.
				self printString do: [:each | each isVowel ifTrue: [count := count + 1]].
				^count'.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: 'var' with: 'count'.
	rewriter replaceArgument: 'var' with: 'count'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> rewriteAllAtTwoToSecond [
	<gtExample>
	| before after rewriter |
	before := 'sum: aCollection
					^aCollection first first + ((aCollection at: 2) at: 2)'.
	after := 'sum: aCollection
					^aCollection first first + aCollection second second'.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: '``@col at: 2' with: '``@col second'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> rewriteAtTwoToSecond [
	<gtExample>
	| before after rewriter |
	before := 'sum: aCollection
					^aCollection first + (aCollection at: 2)'.
	after := 'sum: aCollection
					^aCollection first + aCollection second'.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: '`@col at: 2' with: '`@col second'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> rewriteIfFalseIfTrue [
	<gtExample>
	| before after rewriter |
	before := 'someMethod
					^Array someInstance odd ifFalse: [1] ifTrue: [2]'.
	after := 'someMethod
					^Array someInstance odd ifTrue: [2] ifFalse: [1]'.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: '`@a ifFalse: `@false ifTrue: `@true'
		with: '`@a ifTrue: `@true ifFalse: `@false'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> rewriteToAccessorWhenReceiverOfMessage [
	<gtExample>
	| before after rewriter |
	before := 'someMethod
					self doSomethingWith: collection.
					collection do: [:each | Transcript print: each; cr].
					^ collection'.
	after := 'someMethod
					self doSomethingWith: collection.
					self myCollection do: [:each | Transcript print: each; cr].
					^ collection'.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: 'collection `@selector: `@args'
		with: 'self myCollection `@selector: `@args'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> rewriteToSecond [
	<gtExample>
	| before after rewriter |
	before := 'dist: collection
					^((collection first * collection first) + ((collection at: 2) * (collection at: 2))) sqrt'.
	after := 'dist: collection
					^((collection first * collection first) + (collection second * collection second)) sqrt'.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: 'collection at: 2' with: 'collection second'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> rewriteVariableAtTwoToSecond [
	<gtExample>
	| before after rewriter |
	before := 'sum: firstCollection and: secondCollection
					^{firstCollection first + secondCollection first. (firstCollection at: 2) + (secondCollection at: 2)}'.
	after := 'sum: firstCollection and: secondCollection
					^{firstCollection first + secondCollection first. firstCollection second + secondCollection second}'.
	rewriter := RBParseTreeRewriter new.
	rewriter replace: '`col at: 2' with: '`col second'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> splitCascade [
	<gtExample>
	| before after rewriter |
	before := 'add: anObject andRemove: anotherObject
					| marker index |
					marker := #marker.
					index := collection indexOf: marker.
					collection
						add: marker;
						add: anObject;
						remove: anotherObject;
						removeAtIndex: index.
					^index'.
	after := 'add: anObject andRemove: anotherObject
					| marker index |
					marker := #marker.
					index := collection indexOf: marker.
					collection
						add: marker;
						add: anObject.
					collection
						remove: anotherObject;
						removeAtIndex: index.
					^index'.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: '| `@temps |
					``@.StmtsBefore.
					collection 
						`@;cascadesBefore; 
						add: anObject; 
						remove: anotherObject;
						`@;cascadesAfter.
					``@.StmtsAfter'
		with: '| `@temps |
					``@.StmtsBefore.
					collection 
						`@;cascadesBefore; 
						add: anObject.
					collection
						remove: anotherObject;
						`@;cascadesAfter.
					``@.StmtsAfter'.	"Since we are creating multiple statements fromt he cascade, we need to search for multiple statements"
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> swapAddMessages [
	<gtExample>
	| before after rewriter |
	before := 'createSet
			^ PluggableSet new
				hashBlock: [:each | each hash hashMultiply];
				add: 1;
				add: 2;
				yourself'.
	after := 'createSet
			^ PluggableSet new
				hashBlock: [:each | each hash hashMultiply];
				add: 2;
				add: 1;
				yourself'.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: '`@set `@;messagesBefore; add: `@first; add: `@second; `@;messagesAfter'
		with: '`@set `@;messagesBefore; add: `@second; add: `@first; `@;messagesAfter'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]

{ #category : #examples }
GtRBParseTreeRewriterExamples >> twoTimesRepeat [
	<gtExample>
	| before after rewriter |
	before := 'method
				| oc |
				oc := OrderedCollection new.
				oc add: 1.
				oc add: 1.
				^oc'.
	after := 'method
				| oc |
				oc := OrderedCollection new.
				2 timesRepeat: [oc add: 1].
				^oc'.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: '| `@temps | 
					`@.StatementsBefore.
					`@Expression.
					`@Expression.
					`@.StatementsAfter'
		with: '| `@temps | 
					`@.StatementsBefore.
					2 timesRepeat: [`@Expression].
					`@.StatementsAfter'.
	self assert: (rewriter executeTree: (RBParser parseMethod: before)).
	self assert: rewriter tree equals: (RBParser parseMethod: after).
	^ rewriter tree
]
