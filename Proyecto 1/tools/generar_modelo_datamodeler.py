#!/usr/bin/env python3
"""Construye un diseño relacional OSDM reproducible desde el DDL del proyecto."""

import re
import shutil
import uuid
from pathlib import Path
from xml.sax.saxutils import escape

ROOT = Path(__file__).resolve().parents[1]
DDL = ROOT / "entrega" / "03_creacion_DB.sql"
OUT = ROOT / "modelos" / "Modelo_Comercial_La_Estrella"
DMD = ROOT / "modelos" / "Modelo_Comercial_La_Estrella.dmd"
TEMPLATE = ROOT.parents[0] / "Práctica 2" / "Modelo_Data_Modeler" / "Practica1_EPS"
DESIGN_ID = "D5B84A3E-7D83-4EBA-AD40-2D01A6BAA476"
REL_ID = "92300476-1111-4AAA-8BBB-202609100001"
VIEW_ID = "92300476-2222-4AAA-8BBB-202609100002"


def uid(label):
    return str(uuid.uuid5(uuid.UUID(DESIGN_ID), label)).upper()


def split_items(body):
    result, start, depth = [], 0, 0
    for i, char in enumerate(body):
        depth += char == "("
        depth -= char == ")"
        if char == "," and depth == 0:
            result.append(body[start:i].strip())
            start = i + 1
    result.append(body[start:].strip())
    return result


def parse():
    text = DDL.read_text(encoding="utf-8")
    tables = []
    for match in re.finditer(r"CREATE TABLE\s+(\w+)\s*\((.*?)\);", text, re.S | re.I):
        name, body = match.group(1).upper(), match.group(2)
        columns, primary = [], []
        for item in split_items(body):
            if item.upper().startswith("CONSTRAINT"):
                pk = re.search(r"PRIMARY KEY\s*\(([^)]+)\)", item, re.I)
                if pk:
                    primary = [x.strip().upper() for x in pk.group(1).split(",")]
                continue
            cm = re.match(r"(\w+)\s+((?:NUMBER|VARCHAR2)(?:\([^)]*\))?|DATE)\b(.*)", item, re.I | re.S)
            if not cm:
                continue
            col, datatype, tail = cm.group(1).upper(), cm.group(2).upper(), cm.group(3).upper()
            columns.append((col, datatype, "NOT NULL" in tail))
            if "PRIMARY KEY" in tail:
                primary.append(col)
        tables.append((name, columns, primary))
    return tables


def datatype_xml(datatype):
    if datatype == "DATE":
        return "<logicalDatatype>LOGDT007</logicalDatatype>\n<ownDataTypeParameters>,,</ownDataTypeParameters>"
    if datatype.startswith("VARCHAR2"):
        size = re.search(r"\d+", datatype).group()
        return f"<dataTypeSize>{size}</dataTypeSize>\n<logicalDatatype>LOGDT024</logicalDatatype>\n<ownDataTypeParameters>{size},,</ownDataTypeParameters>"
    nums = re.findall(r"\d+", datatype)
    precision = nums[0] if nums else ""
    scale = nums[1] if len(nums) > 1 else ""
    return f"<logicalDatatype>LOGDT019</logicalDatatype>\n<ownDataTypeParameters>,{precision},{scale}</ownDataTypeParameters>"


def main():
    tables = parse()
    if len(tables) != 19:
        raise SystemExit(f"Se esperaban 19 tablas y se encontraron {len(tables)}")
    if OUT.exists():
        shutil.rmtree(OUT)
    table_dir = OUT / "rel" / REL_ID / "table" / "seg_0"
    subview_dir = OUT / "rel" / REL_ID / "subviews"
    table_dir.mkdir(parents=True)
    subview_dir.mkdir(parents=True)
    objects = []
    view_objects = []
    for pos, (name, columns, primary) in enumerate(tables):
        tid = uid("table:" + name)
        colids = {col: uid(f"column:{name}:{col}") for col, _, _ in columns}
        objects.append(f'   <object objectType="Table" objectID="{tid}" name="{name}" seqName="seg_0" propertyClassName="oracle.dbtools.crest.model.design.relational.Table" propertyParentId="{REL_ID}" propertySourceId="" propertyTargetId=""/>')
        view_objects.append(f'  <OView class="oracle.dbtools.crest.model.design.relational.TableView" oid="{tid}" otype="Table" vid="{uid("view:"+name)}"><bounds x="{80+(pos%5)*320}" y="{70+(pos//5)*250}" width="250" height="190"/></OView>')
        cols = []
        for col, datatype, required in columns:
            use = "1" if required or col in primary else "0"
            cols.append(f'''<Column name="{col}" id="{colids[col]}">
<createdBy>ricardious</createdBy><ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName>
<useDomainConstraints>false</useDomainConstraints><use>{use}</use>
{datatype_xml(datatype)}<autoIncrementCycle>false</autoIncrementCycle>
</Column>''')
        pk_xml = ""
        if primary:
            usages = "".join(f'<colUsage columnID="{colids[c]}"/>' for c in primary)
            pk_xml = f'''<indexes itemClass="oracle.dbtools.crest.model.design.relational.Index">
<ind_PK_UK id="{uid('pk:'+name)}" name="PK_{name}"><createdBy>ricardious</createdBy>
<ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName><pk>true</pk>
<indexState>Primary Constraint</indexState><isSurrogateKey>false</isSurrogateKey>
<indexColumnUsage>{usages}</indexColumnUsage></ind_PK_UK></indexes>'''
        xml = f'''<?xml version="1.0" encoding="UTF-8"?>
<Table class="oracle.dbtools.crest.model.design.relational.Table" directorySegmentName="seg_0" id="{tid}" name="{name}">
<createdBy>ricardious</createdBy><ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName>
<adequatelyNormalized>YES</adequatelyNormalized><allowColumnReorder>false</allowColumnReorder>
<existDependencyGenerateInDDl>true</existDependencyGenerateInDDl><parsed>true</parsed>
<columns itemClass="oracle.dbtools.crest.model.design.relational.Column">{''.join(cols)}</columns>{pk_xml}
</Table>'''
        (table_dir / f"{tid}.xml").write_text(xml, encoding="utf-8")

    (OUT / "rel" / f"{REL_ID}.xml").write_text(f'''<?xml version="1.0" encoding="UTF-8"?>
<relationalModel class="oracle.dbtools.crest.model.design.relational.RelationalDesign" name="MODELO_COMERCIAL_LA_ESTRELLA" id="{REL_ID}" mainViewID="{VIEW_ID}">
<createdBy>ricardious</createdBy><ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName><shouldBeOpen>true</shouldBeOpen>
</relationalModel>''', encoding="utf-8")
    (OUT / "rel" / REL_ID / "Objects.local").write_text('<?xml version="1.0" encoding="UTF-8"?>\n<oracle.dbtools.crest.model.design.relational.RelationalDesign>\n' + "\n".join(objects) + '\n</oracle.dbtools.crest.model.design.relational.RelationalDesign>\n', encoding="utf-8")
    (OUT / "rel" / REL_ID / "Diagrams.local").write_text(f'''<?xml version="1.0" encoding="UTF-8"?>
<oracle.dbtools.crest.model.design.relational.RelationalDesign><object objectType="main_view" objectID="{VIEW_ID}" name="MODELO_COMERCIAL_LA_ESTRELLA" visible="true"/></oracle.dbtools.crest.model.design.relational.RelationalDesign>''', encoding="utf-8")
    (subview_dir / f"{VIEW_ID}.xml").write_text(f'''<?xml version="1.0" encoding="UTF-8"?>
<Diagram class="oracle.dbtools.crest.model.design.relational.RelationalDiagram" id="{VIEW_ID}" name="MODELO_COMERCIAL_LA_ESTRELLA"><createdBy>ricardious</createdBy><ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName>{''.join(view_objects)}</Diagram>''', encoding="utf-8")
    (OUT / "rel" / "Objects.local").write_text(f'''<?xml version="1.0" encoding="UTF-8"?>
<oracle.dbtools.crest.model.design.relational.RelationalDesign><object objectType="RelationalModel" objectID="{REL_ID}" name="MODELO_COMERCIAL_LA_ESTRELLA"/></oracle.dbtools.crest.model.design.relational.RelationalDesign>''', encoding="utf-8")
    for directory in ("datatypes", "rdbms"):
        shutil.copytree(TEMPLATE / directory, OUT / directory)
    for filename in ("dl_settings.xml",):
        shutil.copy2(TEMPLATE / filename, OUT / filename)
    (OUT / "DDL_ORIGEN.sql").write_text(DDL.read_text(encoding="utf-8"), encoding="utf-8")
    DMD.write_text(f'''<?xml version="1.0" encoding="UTF-8"?>
<OSDM_Design class="oracle.dbtools.crest.model.design.Design" name="Modelo_Comercial_La_Estrella" id="{DESIGN_ID}" version="3.5">
<createdBy>ricardious</createdBy><createdTime>2026-09-10 12:00:00 UTC</createdTime>
<ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName><capitalNames>true</capitalNames><designId>{DESIGN_ID}</designId>
</OSDM_Design>''', encoding="utf-8")
    print(f"Modelo generado: {len(tables)} tablas, {sum(len(t[1]) for t in tables)} columnas")


if __name__ == "__main__":
    main()
