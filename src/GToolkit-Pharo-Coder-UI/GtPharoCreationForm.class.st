"
I ensure that all Pharo system modifications happen inside of {{gtMethod: GtPharoCodeModifier >> #critical:}} monitor.
"
Class {
	#name : #GtPharoCreationForm,
	#superclass : #GtCreationForm,
	#category : #'GToolkit-Pharo-Coder-UI-Forms - Models'
}

{ #category : #testing }
GtPharoCreationForm class >> isAbstract [
	^ self name = #GtPharoCreationForm
]

{ #category : #callbacks }
GtPharoCreationForm >> secureCommit [
	"Subclasses may use a mutex/monitor to prevent race conditions."

	^ GtPharoCodeModifier current critical: [ self commit ]
]
