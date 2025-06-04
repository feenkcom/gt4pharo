Class {
	#name : #GtBlocThemeStaticColorType,
	#superclass : #GtBlocThemeStaticProperty,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemeStaticColorType >> assignNewValue: aThemeableValue basedOn: aValueAssignment [
	| colorComputation sourceComputation |
	
	colorComputation := Object compiler evaluate: (GtBlocThemeableProperty generateValueComputation: aValueAssignment valueSourceCode).

	sourceComputation := Object compiler evaluate: (GtBlocThemeableProperty generateSourceComputationFor: aThemeableValue).

	aThemeableValue propertyValue: (BlThemeableColor
		color: colorComputation
		source: sourceComputation
		forTheme: aThemeableValue theme)
]

{ #category : #'as yet unclassified' }
GtBlocThemeStaticColorType >> generateColorThemeableSource: eachAssignment [
	| source |
	source := 'self
				color: {1}
				source: {2}'
			format: {
				GtBlocThemeableProperty generateValueComputation: eachAssignment valueSourceCode.
				GtBlocThemeableProperty generateSourceComputationFor: self themeableValue
			}.
	^ source
]

{ #category : #'as yet unclassified' }
GtBlocThemeStaticColorType >> transformToThemeable [
	| newValue subThemeModelCopy |
	newValue := self themeableValue copy.
	newValue valueAssignments ifEmpty: [ ^ nil ].

	self assignNewValue: newValue basedOn: newValue valueAssignments last.

	newValue copyAndTransformAssignmentsWith: [ :eachAssignment | 
		| source newAst |
		source := self generateColorThemeableSource: eachAssignment.

		newAst := RBParser parseExpression: source.

		eachAssignment subThemeSelector: #initializeThemeable.
		eachAssignment valueAst: newAst ].
			
	subThemeModelCopy := newValue subThemeModel copy.
	subThemeModelCopy
		replaceThemeProperty: self themeableValue
		with: newValue.
	
	^ subThemeModelCopy generateThemeMethods
]
