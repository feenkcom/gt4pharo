Extension { #name : #RPackage }

{ #category : #'*GToolkit-Pharo-Extensions' }
RPackage >> packageManifestOrNil [
	"Avoid using #definedClasses to create a list if classes only to
	select then the one representing the manifest. The manifest is use 
	tp check if the package is deprecated, which in turn can slow down checking
	if class is deprecated.
	Related issue: https://github.com/feenkcom/gtoolkit/issues/4369"
	<gtPharoPatch: #Pharo>
	
	self gtDefinedClassesWithPossibleDuplicatesDo: [:aClass|
		aClass  isManifest ifTrue: [ ^ aClass ] ].
	^ nil
]
