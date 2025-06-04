Class {
	#name : #GtBlocThemeableProperty,
	#superclass : #GtBlocThemeTypedProperty,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty class >> computePropertyAccessApiFromSourceBlock: aBlockClosure useGlobalTheme: useGlobal [
	| rewriter replacement |
	rewriter := RBParseTreeRewriter new
		replace: '[ :`arg | ``@expr ]'
		with: '``@expr'.

	(rewriter executeTree: aBlockClosure sourceNode)
		ifFalse: [ self error: 'Failed to rewrite' ].

	replacement := useGlobal
		ifTrue: [ 'BlTheme default' ]
		ifFalse: [ 'self theme' ].
		
	^ rewriter tree newSource
		copyReplaceAll: 'aTheme'
		with: replacement
]

{ #category : #generation }
GtBlocThemeableProperty class >> generateSourceComputationFor: aThemeProperty [
	^ '[ :aTheme | aTheme {1} {2} ]' format: {
		aThemeProperty subThemeModel subThemeName.
		aThemeProperty propertyName }
]

{ #category : #generation }
GtBlocThemeableProperty class >> generateValueComputation: sourceCode [
	^ '[ :aTheme | {1} ]' format: { sourceCode trimBoth }
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> changeConstantNamed: aConstantName to: anObject [
	self subThemeModel subTheme
		constantAt: aConstantName put: anObject
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> compileConstantAssignment: aCoderAssignment to: anAST [
	aCoderAssignment valueAst: anAST.
	self subThemeModel generateThemeMethods changes execute
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> createCoderViewModel: aCoderModel coderAssignment: aForCoderAssignment [
	| coderViewModel |
	
	coderViewModel := super
		createCoderViewModel: aCoderModel
		coderAssignment: aForCoderAssignment.
	
	self issues ifNotEmpty: [ ^ coderViewModel ].
	
	self
		assert: [ aForCoderAssignment isConstantAssignment ]
		description: [ 'Must be a constant assignment' ].	
	
	aCoderModel 
		when: GtCoderEvaluationAnnouncement
		do: [ :anAnnouncement |
			anAnnouncement evaluationResult isSuccess
				ifTrue: [				
					self
						changeConstantNamed: aForCoderAssignment propertyName
						to: anAnnouncement evaluationResult value.
					self subThemeModel subTheme theme themeModified  ] ].
						
	coderViewModel addShortcut: (GtSourceCoderSaveShortcut new).
	coderViewModel announcer
		when: GtSourceCoderViewModelSaveRequested
		do: [ :anAnnouncement |
			anAnnouncement consumed: true.
			
			 coderViewModel
				handleCoderEvaluationUnhandledErrorDuring: [ 
					coderViewModel coder
						doItInContext: (coderViewModel evaluationContext
							all;
							requesterObject: coderViewModel)
						thenDo: [ :anEvaluationResult |
							self
								compileConstantAssignment: aForCoderAssignment originalAssignment
								to: (RBParser parseExpression: coderViewModel sourceText asString).
							self
								changeConstantNamed: aForCoderAssignment propertyName
								to: anEvaluationResult value.
							self subThemeModel subTheme theme themeModified ] ].
			 ].
	
	^ coderViewModel
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> extractPropertyConstantAst: aPropertyAssignment [
	^ self subclassResponsibility
]

{ #category : #generation }
GtBlocThemeableProperty >> generateConstantGetter [
	^ 'aTheme {1} constantAt: #{2}' format: {
		self subThemeModel subThemeName.
		self propertyName
	}
]

{ #category : #generation }
GtBlocThemeableProperty >> generateSourceComputation [
	^ self class generateSourceComputationFor: self themeableValue
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> generateThemeableInitializationSource [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> isThemeableType [
	^ true
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> issuesOn: aStream [
	super issuesOn: aStream.
	
	self themeProperty hardcodedValueAssignments do: [ :eachAssignment |
		aStream nextPut: (GtBlocThemeablePropertyHardcodedIssue new typedThemeableProperty: self; valueAssignment: eachAssignment) ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeableProperty >> transformAssignmentForCoder: aThemeableAssignment [
	self issues
		ifNotEmpty: [ ^ aThemeableAssignment ].

	^ self constantAssignments
		detect: [ :eachAssignment |
			eachAssignment subThemeClass = aThemeableAssignment subThemeClass ]
		ifNone: [ self constantAssignments last ]
]
