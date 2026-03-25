Class {
	#name : #GtClassOperationDoneExamples,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'GToolkit-Pharo-System'
}

{ #category : #cleanup }
GtClassOperationDoneExamples >> cleanUp [
	environment ifNotNil: [ :anEnvironment | anEnvironment removeFromSystem ]
]

{ #category : #examples }
GtClassOperationDoneExamples >> testClassRenameGeneratedWriteAnnouncements [
	<gtExample>
	<after: #cleanUp>
	| realClass className classRenamed counter classRenamedCounter classRenameDone classRenameDoneCounter newClassName |
	environment := GtPharoDummiesGenerator withPackages: 1 classes: 1.

	realClass := environment anyDummyRootClass realClass.
	className := realClass name.

	counter := 1.
	SystemAnnouncer uniqueInstance weak
		when: ClassRenamed
		do: [ :anAnnouncement | 
			classRenamed := anAnnouncement.
			classRenamedCounter := counter.
			counter := counter + 1 ]
		for: self.
	SystemAnnouncer uniqueInstance weak
		when: GtClassRenamedDone
		do: [ :anAnnouncement | 
			classRenameDone := anAnnouncement.
			classRenameDoneCounter := counter.
			counter := counter + 1 ]
		for: self.

	newClassName := className , '_1'.
	realClass rename: newClassName.
	SystemAnnouncer uniqueInstance unsubscribe: self.
	
	self assert: counter equals: 3.
	self assert: classRenamedCounter equals: 1.
	self assert: classRenameDoneCounter equals: 2.
	
	self assert: classRenameDone oldName equals: className.
	self assert: classRenameDone newName equals: newClassName.
	self assert: classRenameDone classRenamed equals: realClass.
	self assert: classRenameDone classAffected equals: realClass.
	self 
		assert: classRenameDone packagesAffected anyOne 
		equals: environment anyDummyPackage realPackage.
		
	self assert: classRenamed oldName equals: className.
	self assert: classRenamed newName equals: newClassName.
	self assert: classRenamed classRenamed equals: realClass.
	self assert: classRenamed classAffected equals: realClass.
	self 
		assert: classRenamed packagesAffected anyOne 
		equals: environment anyDummyPackage realPackage.
		
	

	^ classRenameDone
]
