Class {
	#name : #GtCopyClassForm,
	#superclass : #Object,
	#instVars : [
		'innerClass',
		'superClassName',
		'onAccept',
		'newClassName',
		'packageAndTag',
		'copyMethods'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Behavior'
}

{ #category : #'instance creation' }
GtCopyClassForm class >> for: aClass [
	^ self new for: aClass
]

{ #category : #converting }
GtCopyClassForm >> asElement [
	^ self asGtMagritteViewModel focusFirstInputField asElement
]

{ #category : #accessing }
GtCopyClassForm >> buildNewDefinitionFrom: oldDefinition [
	| ast rewriter replacedName category replacedSuper messages receiver |
	ast := RBParser parseExpression: oldDefinition.
	replacedName := false.
	replacedSuper := false.
	rewriter := RBParseTreeRewriter new.
	rewriter
		replace: innerClass name asSymbol printString
		with: newClassName trim asSymbol printString
		when: [ :node | 
			node parent isMessage
				and: [ node parent arguments first == node
						and: [ (node parent selector keywords first = '<<'
								or: [ node parent selector keywords first asLowercase endsWith: 'subclass:' ])
								and: [ replacedName := true ] ] ] ].
	rewriter
		replace: (innerClass superclass ifNil: [ 'nil' ] ifNotNil: [ :spr | spr name ])
		with: superClassName trim
		when: [ :node | 
			node parent isMessage
				and: [ node parent receiver == node and: [ replacedSuper := true ] ] ].
	(rewriter executeTree: ast) ifTrue: [ ast := rewriter tree ].
	(replacedName
		and: [ replacedSuper and: [ ast isCascade or: [ ast isMessage ] ] ])
		ifFalse: [ self error: 'Invalid definition string' ].
	ast isMessage
		ifTrue: [ (ast receiver isMessage and: [ ast receiver selector = #'<<' ])
				ifTrue: [ ast := RBCascadeNode messages: {ast copy} ]
				ifFalse: [ ast arguments isEmpty ifTrue: [ self error: 'Invalid definition string' ].
					category := packageAndTag tagName trim
							ifEmpty: [ packageAndTag packageName trim ]
							ifNotEmpty: [ packageAndTag fullName ].
					ast selector keywords
						with: ast arguments
						do: [ :key :arg | 
							(#('package:' 'category:') includes: key)
								ifTrue: [ arg replaceWith: (RBLiteralValueNode value: category) ] ] ] ].
	ast isCascade
		ifTrue: [ messages := ast messages
					reject: [ :e | #(package: tag:) includes: e selector ].
			receiver := ast messages first receiver ].
	(ast isMessage and: [ ast selector = #'<<' ])
		ifTrue: [ messages := OrderedCollection new.
			receiver := ast ].
	messages
		ifNotNil: [ packageAndTag tagName trim
				ifNotEmpty: [ :tag | 
					messages
						add: (RBMessageNode
								receiver: receiver
								selector: #tag:
								arguments: {RBLiteralValueNode value: tag}) ].
			messages
				add: (RBMessageNode
						receiver: receiver
						selector: #package:
						arguments: {RBLiteralValueNode value: packageAndTag packageName trim}).
			ast := RBCascadeNode messages: (messages collect: #copy) ].
	^ ast formattedCode
]

{ #category : #accessing }
GtCopyClassForm >> copyClass [
	| model oldClass newClass definition |
	model := GtRBNamespace new.
	definition := self buildNewDefinitionFrom: innerClass definitionString.
	model defineClass: definition.
	newClass := model classNamed: newClassName trim asSymbol.
	innerClass classSide instVarNames
		do: [ :each | newClass classSide addInstanceVariable: each ].
	copyMethods
		ifTrue: [ oldClass := model classFor: innerClass.
			(oldClass allMethods select: [ :method | method methodClass = oldClass ])
				do: [ :method | newClass compile: method source classified: method protocols ].
			(oldClass classSide allMethods
				select: [ :method | method methodClass = oldClass classSide ])
				do: [ :method | newClass classSide compile: method source classified: method protocols ] ].
	GtPharoCodeModifier current performRefactoryChange: model changes.
	^ newClassName trim asSymbol asClass
]

{ #category : #accessing }
GtCopyClassForm >> copyMethods [

	^ copyMethods
]

{ #category : #accessing }
GtCopyClassForm >> copyMethods: anObject [

	copyMethods := anObject
]

{ #category : #magritte }
GtCopyClassForm >> copyMethodsDescription [
	<magritteDescription>
	^(MABooleanDescription new)
		label: 'Copy methods';
		priority: 3;
		accessor: #copyMethods;
		editorAptitude: 
				[BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize];
		labelAptitude: [BrGlamorousLabelAptitude new glamorousFormLabelStyle]
]

{ #category : #accessing }
GtCopyClassForm >> for: aClass [
	innerClass := aClass.
	newClassName := aClass name asString.
	superClassName := aClass superclass name asString.
	copyMethods := true.
	packageAndTag := GtPackageAndTagName new
			packageName: aClass package name;
			tagName: (self treatTag: aClass)
]

{ #category : #accessing }
GtCopyClassForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		label: 'Copy';
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | 
					[ | aClass |
					aClass := GtPharoCodeModifier current critical: [ self copyClass ].
					onAccept ifNotNil: [ onAccept value: aClass ] ] on: Error do: #debug ])
]

{ #category : #magritte }
GtCopyClassForm >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Name';
		priority: 1;
		accessor: #newClassName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocCompletion: [ GtPharoCodeModifier current
				critical: [ GtStringsCompletionStrategy new
						completions: (GtPrefixTree withAll: Smalltalk classNames) ] ];
		addCondition: [ :aValue | (Smalltalk classNamed: aValue trim) isNil ]
			labelled: 'Class name is already taken';
		addCondition: [ :aValue | aValue isEmpty or: [ aValue first isUppercase ] ]
			labelled: 'First character must be uppercase';
		addCondition: [ :aValue | aValue asString allSatisfy: [ :c | c isAlphaNumeric or: [ c = $_ ] ] ]
			labelled: 'Class name must be alphanumeric'
]

{ #category : #accessing }
GtCopyClassForm >> newClassName [

	^ newClassName
]

{ #category : #accessing }
GtCopyClassForm >> newClassName: anObject [

	newClassName := anObject
]

{ #category : #accessing }
GtCopyClassForm >> onAccept: anAction [
	onAccept := anAction
]

{ #category : #accessing }
GtCopyClassForm >> packageAndTag [
	^ packageAndTag
]

{ #category : #accessing }
GtCopyClassForm >> packageAndTag: anObject [
	packageAndTag := anObject
]

{ #category : #magritte }
GtCopyClassForm >> packageAndTagDescription [
	<magritteDescription>
	^ GtPackageAndTagDescription new
		label: 'Package';
		priority: 3;
		accessor: #packageAndTag;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #magritte }
GtCopyClassForm >> superClassDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Superclass';
		priority: 2;
		accessor: #superClassName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		blocCompletion: [ GtPharoCodeModifier current
				critical: [ GtStringsCompletionStrategy new
						completions: (GtPrefixTree withAll: Smalltalk classNames) ] ];
		addCondition: [ :aValue | (Smalltalk classNamed: aValue trim) isNotNil ]
			labelled: 'Class does not exist'
]

{ #category : #accessing }
GtCopyClassForm >> superClassName [

	^ superClassName
]

{ #category : #accessing }
GtCopyClassForm >> superClassName: anObject [

	superClassName := anObject
]

{ #category : #accessing }
GtCopyClassForm >> treatTag: aClass [
	| aCategoryName aPackageName aTagString |
	aCategoryName := aClass category.
	aPackageName := aClass package name.

	aTagString := (aCategoryName beginsWith: aPackageName)
			ifFalse: [ '' ]
			ifTrue: [ aCategoryName allButFirst: aPackageName size ].

	^ aTagString trimBoth: [ :aChar | aChar = $- or: [ aChar isSeparator ] ]
]
