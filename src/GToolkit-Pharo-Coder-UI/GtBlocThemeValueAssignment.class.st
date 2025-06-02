Class {
	#name : #GtBlocThemeValueAssignment,
	#superclass : #GtBlocThemePropertyAssignment,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #views }
GtBlocThemeValueAssignment >> gtValueAstFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		priority: 5;
		object: [ valueAst ];
		view: #gtSourceCodeFor:
]
