Class {
	#name : #GtShiftClassBuilder12,
	#superclass : #ShiftClassBuilder,
	#category : #'GToolkit-Pharo-Index'
}

{ #category : #building }
GtShiftClassBuilder12 >> build [

	self tryToFillOldClass.
	self detectBuilderEnhancer.
	self builderEnhancer validateRedefinition: self oldClass.

	self validateSuperclass.
	self compareWithOldClass.

	"If this is the first build, when building a class.
	We need to check if there is no conflicts with existing subclasses.
	If we are in a remake, it have been done when building the superclass modified before."

	self isInRemake ifFalse: [ self layoutDefinition validate ].

	self createMetaclass.
	self createClass.

	self oldClass ifNotNil: [
		self copyProtocols.
		self newClass commentSourcePointer: self oldClass commentSourcePointer ].

	self createSharedVariables.

	self installSlotsAndVariables.

	self environment codeChangeAnnouncer announce: 
		(ClassAdded class: newClass).
	self oldClass ifNotNil: [ self builderEnhancer compileMethodsFor: self ].

	self builderEnhancer afterMethodsCompiled: self.
	^ newClass
]
