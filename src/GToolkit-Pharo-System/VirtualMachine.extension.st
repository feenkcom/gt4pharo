Extension { #name : #VirtualMachine }

{ #category : #'*GToolkit-Pharo-System' }
VirtualMachine >> avoidSearchingSegmentsWithPinnedObjects [
	"Answer a boolean indicating how pinned objects are allocated.
	true = pinned objects may appear anywhere in old-space.
	false = pinned objects are grouped together where possible."
	<gtPharoPatch: #Pharo11>

	^ self parameterAt: 86
]

{ #category : #'*GToolkit-Pharo-System' }
VirtualMachine >> avoidSearchingSegmentsWithPinnedObjects: aBoolean [
	<gtPharoPatch: #Pharo11>

	^ self parameterAt: 86 put: aBoolean 
]

{ #category : #'*GToolkit-Pharo-System' }
VirtualMachine >> parameterLabels [
	"The indices and label of each VM parameter.
	 Only one single (machine-processable) list to maintain in the Image side, marvelous!"
	<gtPharoPatch: #Pharo11>

	^ #(
		1 'size of old-space (0-based, read-only)'
		2 'size of young/new-space (read-only)'
		3 'size of heap (read-only)'
		4 'nil (was allocationCount (read-only))'
		5 'nil (was allocations between GCs (read-write)'
		6 'survivor count tenuring threshold (read-write)'
		7 'full GCs since startup (read-only)'
		8 'total milliseconds in full GCs since startup (read-only)'
		9 'scavenges since startup (read-only)'
		10 'total milliseconds in scavenges since startup (read-only)'
		11 'tenures of surving objects since startup (read-only)'
		12 '12-20 were specific to ikp''s JITTER VM, now 12-15 are open for use'
		16 'total microseconds at idle since start-up (if non-zero, read-only)'
		17 'fraction of the code zone to use (Sista only, read-only)'
		18 'total milliseconds in compaction phase of full GC since start-up (read-only)'
		19 'scavenge threshold, the effective size of eden.  When eden fills to the threshold a scavenge is scheduled (read-only)'
		20	'utc microseconds at VM start-up (actually at time initialization, which precedes image load, read-only).'
		21	'root table size (read-only)'
		22	'root table overflows since startup (read-only)'
		23	'bytes of extra memory to reserve for VM buffers, plugins, etc (stored in image file header, read-write)'
		24	'memory threshold above which shrinking object memory (read-write)'
		25	'memory headroom when growing object memory (read-write)'
		26	'interruptChecksEveryNms - force an ioProcessEvents every N milliseconds (read-write)'
		27 'number of times mark loop iterated for current IGC/FGC (read-only)	includes ALL marking'
		28	'number of times sweep loop iterated for current IGC/FGC (read-only)'
		29	'number of times make forward loop iterated for current IGC/FGC (read-only)'
		30	'number of times compact move loop iterated for current IGC/FGC (read-only)'
		31	'number of grow memory requests (read-only)'
		32	'number of shrink memory requests (read-only)'
		33	'number of root table entries used for current IGC/FGC (read-only)'
		34	'bytes allocated in total since start-up or reset (read-write)'
		35	'number of survivor objects after current IGC/FGC (read-only)'
		36	'millisecond clock when current IGC/FGC completed (read-only)'
		37	'number of marked objects for Roots of the world, not including Root Table entries for current IGC/FGC (read-only)'
		38	'milliseconds taken by current IGC (read-only)'
		39	'Number of finalization signals for Weak Objects pending when current IGC/FGC completed (read-only)'
		40	'BytesPerOop for this image (read-only)'
		41	'imageFormatVersion for the VM (read-only)'
		42	'number of stack pages in use (read-only)'
		43	'desired number of stack pages (stored in image file header, max 65535, read-write)'
		44	'size of eden, in bytes (read-only)'
		45	'desired size of new space (new space is 5/7 eden and 2/7 survivor space), in bytes (stored in image file header, read-write)'
		46	'machine code zone size, in bytes (Cog only; otherwise nil, read-only)'
		47	'desired machine code zone size (stored in image file header; Cog only; otherwise nil, read-write)'
		48	'various header flags. See getCogVMFlags (read-write)'
		49	'max size the image promises to grow the external semaphore table to (0 sets to default, which is 256 as of writing, read-write)'
		50	'nil; reserved for VM parameters that persist in the image (such as eden above)' "What does that mean?"
		51 	'nil; reserved for VM parameters that persist in the image (such as eden above)'
		52	'root table capacity (read-only)'
		53	'number of segments (read-only)'
		54	'total size of free old space (read-only)'
		55	'ratio of growth and image size at or above which a GC will be performed post scavenge (read-write)'
		56	'number of process switches since startup (read-only)'
		57	'number of ioProcessEvents calls since startup (read-only)'
		58	'number of ForceInterruptCheck calls since startup (read-only)'
		59	'number of check event calls since startup (read-only)'
		60	'number of stack page overflows since startup (read-only)'
		61	'number of stack page divorces since startup (read-only)'
		62	'compiled code compactions since startup (read-only; Cog only; otherwise nil)'
		63	'total milliseconds in compiled code compactions since startup (read-only; Cog only; otherwise nil)'
		64	'the number of methods that currently have jitted machine-code (read-only)'
		65	'whether the VM supports a certain feature, MULTIPLE_BYTECODE_SETS is bit 0, IMMUTABILITY is bit 1, HEARTBEAT is bit 2 (read-only)'
		66	'the byte size of a stack page (read-only)'
		67	'the max allowed size of old space (0 implies no limit except that of the underlying platform, read-write)'
		68	'the average number of live stack pages when scanned by GC (at scavenge/gc/become et al, read-write)'
		69	'the maximum number of live stack pages when scanned by GC (at scavenge/gc/become et al, read-write)'
		70	'the vmProxyMajorVersion (the interpreterProxy VM_MAJOR_VERSION, read-only)'
		71	'the vmProxyMinorVersion (the interpreterProxy VM_MINOR_VERSION, read-only)'
		72 'total milliseconds in full GCs Mark phase since startup (read-only)'
		73 'total milliseconds in full GCs Sweep phase since startup (read-only, can be 0 depending on compactors)'
		74 'maximum pause time due to segment allocation (read-write)'
		75 'number of JIT compiled methods since startup (read-only)'
		76 'total milliseconds spent on JIT compiled methods since startup (read-only)'
		77 'number of JIT compiled block since startup (read-only)'
		78 'total milliseconds spent on JIT compiled block since startup (read-only)'
		79 'Image version stored in the header of the image file'
		86 'If avoids to search a segment with pinned objects when clonning a young object'
		)
]
