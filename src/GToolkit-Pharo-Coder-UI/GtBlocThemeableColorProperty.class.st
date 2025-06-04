Class {
	#name : #GtBlocThemeableColorProperty,
	#superclass : #GtBlocThemeableProperty,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #generation }
GtBlocThemeableColorProperty class >> generateColorThemeableSourceFor: aThemeableValue valueSource: aValueSource [
	| source |
	source := 'self
				color: {1}
				source: {2}'
			format: {
				self generateValueComputation: aValueSource.
				self generateSourceComputationFor: aThemeableValue
			}.
	^ source
]

{ #category : #'as yet unclassified' }
GtBlocThemeableColorProperty class >> matchesThemeProperty: aThemeProperty [
	| valueAssignment expectedAssignment |

	(aThemeProperty propertyValue isKindOf: BlThemeableColor)
		ifFalse: [ ^ false ].

	^ true

	"aThemeProperty amountOfValueAssignments = 1
		ifFalse: [ ^ false ].

	aThemeProperty constantAssignments size > 0
		ifFalse: [ ^ false ].

	valueAssignment := aThemeProperty valueAssignments first.
	expectedAssignment := RBPatternParser parseExpression: ('self
		color: [ :aTheme | aTheme {1} constantAt: #{2} ]
		source: [ :aTheme | aTheme {1} {2} ]' format: {
			aThemeProperty subThemeModel subThemeName.
			aThemeProperty propertyName
		}).
	
	^ expectedAssignment match: valueAssignment valueAst inContext: Dictionary new"
]

{ #category : #'as yet unclassified' }
GtBlocThemeableColorProperty >> extractPropertyConstantAst: aPropertyAssignment [
	| pattern matches ast rewriter |

	pattern := RBPatternParser parseExpression: ('self
		color: [ :aTheme | `@constant ]
		source: [ :aTheme | aTheme {1} {2} ]' format: {
			self subThemeModel subThemeName.
			self propertyName
		}).
		
	(pattern match: aPropertyAssignment valueAst inContext: (matches := Dictionary new))
		ifFalse: [ ^ nil ].

	ast := matches values
		ifEmpty: [ ^ nil ]
		ifNotEmpty: [ :theValues | theValues first ].
		
	rewriter := RBParseTreeRewriter new
		replace: 'aTheme ``@expr'
		with: 'self theme ``@expr'.
		
	^ (rewriter executeTree: ast)
		ifTrue: [ rewriter tree ]
		ifFalse: [ ^ ast ]
]

{ #category : #'as yet unclassified' }
GtBlocThemeableColorProperty >> generateThemeableInitializationSource [
	^ self class
		generateColorThemeableSourceFor: self themeableValue
		valueSource: self generateConstantGetter
]

{ #category : #'as yet unclassified' }
GtBlocThemeableColorProperty >> initializeForThemeProperty: aThemeProperty [
	super initializeForThemeProperty: aThemeProperty.
	
	
]
