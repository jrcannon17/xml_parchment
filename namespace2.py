import os
import xml.etree.ElementTree as ET
import re
from io import StringIO

'''
-------------STEP 1---------------------
 create function
 '''
def Transform_Parchment(parchment):
    '''this works'''
        #file to be changed
    with (
        open(parchment, 'r+') as f
        ):
        tree = ET.parse(f)
        root_output = tree.getroot()

    '''
    -----------------STEP 2-------------------
    Find and store name of student from file. Will be used as part of the new naming convention
    
    '''
    try:
        Student = []
        for name in root_output[1][0][2]:

            if 'Name' in name:
                print(name)
            temp = name.text.split()
            for x in temp:
                Student.append(x)
                for name in f:
                    file = name.split()
                    new_f = file.insert(-1, Student[2])
                    os.rename(f, new_f)
                    # print(new_f)
    except IndexError:
        NStudent = ''
    else:
        NStudent = Student[0] + '_' + Student[2]

    # print(NStudent)

    '''
    ----------------STEP 3 ---------------------------
    Next, create and insert FICE code under Organization before the CEEBACT child
    '''

    FICE_tag = ET.Element("FICE")
    FICE_tag.text = "009917"
    for element in root_output.findall("./TransmissionData/Source/"):
        if element.tag == 'Organization':
            # print(element)
            element.insert(1, FICE_tag)
        # print(element)
        #ET.dump(element)
    '''
    -------------------STEP 4----------------------
    replace current root with ColTrn Tag with appropiate namespaces, prefixes and attributes by the following:
    1. create desired root attributes as a dictionary
    2. create root element (also as a dictionary) seperate from the inner attributes
    3. Register name spaces (if not registered, Banner will flag as an error
    4. Swap current root with new root 
    5. Write all changes so far into parchment file
    ----update---
    I highly HIGHLY recommend looking up the QName function and what it actually does
    Due to time constraints, I toss out the tag element and manually write in the element with QName HOWEVER
    I believe this can be done with QName with the ns dict but I will need to test more and we simply do not
    have the time for this at the moment. If I find the appropiate method, I will update the file as this method
    should and IS the preferred way.
    '''

    #create dictionary of namespaces contained in the ColTrn tag

    ns_map = {

        "xsi:schemaLocation": "urn:org:pesc:message:AcademicRecordBatch:v1.6.0 http://www/pesc.org/info/docs/college_transcript/CollegeTranscript_v1.6.0.xsd",
        "xmlns:ColTrn": "urn:org:pesc:message:CollegeTranscript:v1.6.0",
        "xmlns:core": "urn:org:pesc:core:CoreMain:v1.14.0",
        "xmlns:AcRec": "urn:org:pesc:sector:AcademicRecord:v1.9.0",
        "xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance"}

    #create name space for the actual tag

    ns = {"ColTrn": "CollegeTranscript"}
    #now we register the name spaces
    '''we do this twice for two reasons
        1: the tag itself is a name space so this is separated because
        2: the tag is nothing but several namespaces
        if the main tag is included in ns_map, then only ONE name space can be declared.
        Ultimately, only the selected [key] will display the namespace instead of the entire dict'''

    for prefix, uri in ns_map.items():
            ET.register_namespace(prefix, uri)

    for prefix, uri in ns.items():
            ET.register_namespace(prefix,uri)


    '''changes to ns0 so we can't use this. Do you know why? Look up QName and it should be obvious'''
    # rootCol = ET.Element(ET.QName(ns_map["ColTrn"], "CollegeTranscript"))
    '''^^^^'''
    # so now that we defined the TAG earlier, we will append the dict of namespaces to the tag
    '''tags xmlns:Col to it so we can't use this either. What we have in ns_map should be the ONLY 
    namespaces contained within the root element. If we use ns with QName in this way, what happens is 
    automatically, xmlns will be given to ns and WE DON'T WANT THIS!!!!
    I think that registering ns earlier may be a contributing factor but I further suspect it has to do 
    with how ns is being used in QName.'''
    # rootCol = ET.Element(ET.QName(ns["ColTrn"], "CollegeTranscript"), ns_map)

    '''We will use this for now. It works so I'm happy...but not really'''
    rootCol = ET.Element(ET.QName("ColTrn:CollegeTranscript"), ns_map)
    '''^^^^^'''

    ''' 
    now swap the current root out with the one we just created. You may be asking, 'why remove the root and place the new one as root?'
    Because if we don't, then all child elements of the prior root will be removed and this will essentially be for nothing.
    We don't want that so we're swapping attributes and tags instead, this way, the children/data will still remain'''

    root_output.tag = rootCol.tag
    root_output.attrib = rootCol.attrib

    '''Now create the primary root for the new file. This will then be used as the anchor 
       to append the root created previously
       ----UPDATE***
       We actually don't use this. I wanted to initially but problems will emerge if we do. I will explain more in next step
       '''
    urn_ns = {"urn": "urn:org:pesc:message:AcademicRecordBatch:v1.0.0"}
    ET.register_namespace('urn', urn_ns["urn"])
    new_root = ET.Element(ET.QName(urn_ns["urn"], "AcademicRecordBatch"))
    # ET.dump(new_root)

    '''DO NOT DELETE CODE BELOW WITH NEWROOT!!!'''
    # new_root.append(root_output)

    ET.ElementTree(root_output).write(parchment, xml_declaration=True, encoding="utf-8")

    # ET.dump(root_output)
    f.close()

    '''
    ------------STEP 5------------------------
    
    Delete the first line of the new file, which is the shebang. If we don't, then there will be two shebangs in the 
    new file and it will read as an error.
    
    '''
    try:
        with open(parchment, 'rt') as fr:
            # reading line by line
            lines = fr.readlines()

            ptr = 1
            count = 0
            for line in lines:
                count += 1
                # print(line[1])
            # opening in writing mode
            with open(parchment, 'wt') as fw:
                for line in lines:
                    # we want to remove 0th line
                    if ptr != 1:
                        fw.write(line)
                    ptr += 1
        print("Deleted")

    except:
        print("Oops! something error")

    '''
    --------------- STEP 6-----------
    
    Now append the transformed transcript over to a new file starting with students name.
    Notice that in the new file, we are manually writing not only te shebang, but the dominate root, URN. 
    We must do this unfortunatelly, because if we don't, what will happen is that the URN root will be followed by the shebang
    THEN the root col we just made prior to this step. So we tossed the 0th line from the previous file and 
    essentially started from scratch, appending only what we needed. Same would happen if we used the URN namespace 
    from the file above. If we append to it that way, then the URN closing tag will be followed by the COL element and
    we don't want that. We want the COL to be a child of URN as a holistic piece
    
        '''
    with open(parchment, 'r') as f:
        data = f.read()
    with open(NStudent+parchment, 'a') as g:
        g.write("""<?xml version="1.0" encoding="UTF-8"?>\n<urn:AcademicRecordBatch xmlns:urn="urn:org:pesc:message:AcademicRecordBatch:v1.0.0"> \n""" + data + "\n</urn:AcademicRecordBatch>\n")

        g.close()

    return

'''search current directory for all xml files and perform Transform_Parchment()'''

'''
------STEP 7-------
find xml files and run parchment() on it.

'''
# try:
#     i = 0
#     for x in os.listdir():
#         if x.endswith(".xml"): #and x.startswith('TWV'):
#             #print .xml files in directory
#             print(x)
#             Transform_Parchment(x)
#             # if os.path.exists(x % i):
#             #     i+=1
#             # fh = open(x %i, "w")
# except:
#     print("Problem with parchment")
missed = []
for x in os.listdir():
    if x.endswith(".xml"):  # and x.startswith('TWV'):
        # print .xml files in directory
        print(x)
        with open(x, 'r') as f:
            lines = f.readlines()
            if '<?' in lines:

                Transform_Parchment(x)
            else:
                print('pass')