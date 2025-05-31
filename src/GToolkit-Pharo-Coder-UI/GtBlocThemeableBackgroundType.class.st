Class {
	#name : #GtBlocThemeableBackgroundType,
	#superclass : #GtBlocThemeableValueType,
	#category : #'GToolkit-Pharo-Coder-UI-Utilities'
}

{ #category : #'as yet unclassified' }
GtBlocThemeableBackgroundType >> simplifiedAssignmentAst: aThemeableAssignment [
	| anAst |

	anAst := aThemeableAssignment valueAst.
	anAst isMessageSend
		ifFalse: [ ^ anAst ].
		
	anAst selector = #background:source:
		ifFalse: [ ^ anAst ].

	anAst arguments first isBlock
		ifFalse: [ ^ anAst ].
		
	^ anAst arguments first body
]
