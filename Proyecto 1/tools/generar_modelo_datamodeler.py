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
        columns, primary, uniques, foreign = [], [], [], []
        for item in split_items(body):
            if item.upper().startswith("CONSTRAINT"):
                pk = re.search(r"PRIMARY KEY\s*\(([^)]+)\)", item, re.I)
                if pk:
                    primary = [x.strip().upper() for x in pk.group(1).split(",")]
                uq = re.search(r"UNIQUE\s*\(([^)]+)\)", item, re.I)
                if uq:
                    uniques.append([x.strip().upper() for x in uq.group(1).split(",")])
                fk = re.search(r"CONSTRAINT\s+(\w+)\s+FOREIGN KEY\s*\(([^)]+)\)\s+REFERENCES\s+(\w+)\s*\(([^)]+)\)", item, re.I | re.S)
                if fk:
                    foreign.append((fk.group(1).upper(), [x.strip().upper() for x in fk.group(2).split(",")], fk.group(3).upper(), [x.strip().upper() for x in fk.group(4).split(",")]))
                continue
            cm = re.match(r"(\w+)\s+((?:NUMBER|VARCHAR2)(?:\([^)]*\))?|DATE)\b(.*)", item, re.I | re.S)
            if not cm:
                continue
            col, datatype, tail = cm.group(1).upper(), cm.group(2).upper(), cm.group(3).upper()
            columns.append((col, datatype, "NOT NULL" in tail))
            if "PRIMARY KEY" in tail:
                primary.append(col)
        tables.append((name, columns, primary, uniques, foreign))
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
    table_ids = {table[0]: uid("table:" + table[0]) for table in tables}
    column_ids = {table[0]: {col: uid(f"column:{table[0]}:{col}") for col, _, _ in table[1]} for table in tables}
    key_ids = {}
    for name, _, primary, uniques, _ in tables:
        key_ids[(name, tuple(primary))] = uid("pk:" + name)
        for cols in uniques:
            key_ids[(name, tuple(cols))] = uid("uq:" + name + ":" + ":".join(cols))
    foreign_by_column = {}
    for child, _, _, _, fks in tables:
        for fk_name, local_cols, parent, ref_cols in fks:
            for local, referred in zip(local_cols, ref_cols):
                foreign_by_column[(child, local)] = (uid("fk:" + fk_name), column_ids[parent][referred])

    fk_dir = OUT / "rel" / REL_ID / "foreignkey" / "seg_0"
    fk_dir.mkdir(parents=True)
    for pos, (name, columns, primary, uniques, foreign) in enumerate(tables):
        tid = table_ids[name]
        colids = column_ids[name]
        objects.append(f'   <object objectType="Table" objectID="{tid}" name="{name}" seqName="seg_0" propertyClassName="oracle.dbtools.crest.model.design.relational.Table" propertyParentId="{REL_ID}" propertySourceId="" propertyTargetId=""/>')
        view_objects.append(f'  <OView class="oracle.dbtools.crest.model.design.relational.TableView" oid="{tid}" otype="Table" vid="{uid("view:"+name)}"><bounds x="{80+(pos%5)*320}" y="{70+(pos//5)*250}" width="250" height="190"/></OView>')
        cols = []
        for col, datatype, required in columns:
            use = "1" if required or col in primary else "0"
            association = ""
            if (name, col) in foreign_by_column:
                fk_id, referred_id = foreign_by_column[(name, col)]
                association = f'<associations><colAssociation fkAssociation="{fk_id}" referredColumn="{referred_id}"/></associations>'
            cols.append(f'''<Column name="{col}" id="{colids[col]}">
<createdBy>ricardious</createdBy><ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName>
<useDomainConstraints>false</useDomainConstraints><use>{use}</use>
{datatype_xml(datatype)}<autoIncrementCycle>false</autoIncrementCycle>{association}
</Column>''')
        index_items = []
        if primary:
            usages = "".join(f'<colUsage columnID="{colids[c]}"/>' for c in primary)
            index_items.append(f'''<ind_PK_UK id="{uid('pk:'+name)}" name="PK_{name}"><createdBy>ricardious</createdBy>
<ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName><pk>true</pk>
<indexState>Primary Constraint</indexState><isSurrogateKey>false</isSurrogateKey>
<indexColumnUsage>{usages}</indexColumnUsage></ind_PK_UK>''')
        for uq_cols in uniques:
            usages = "".join(f'<colUsage columnID="{colids[c]}"/>' for c in uq_cols)
            uq_id = key_ids[(name, tuple(uq_cols))]
            index_items.append(f'''<ind_PK_UK id="{uq_id}" name="UQ_{name}_{'_'.join(uq_cols)}"><createdBy>ricardious</createdBy>
<ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName><unique>true</unique>
<indexState>Unique Constraint</indexState><isSurrogateKey>false</isSurrogateKey><indexColumnUsage>{usages}</indexColumnUsage></ind_PK_UK>''')
        for fk_name, local_cols, parent, ref_cols in foreign:
            fk_id, index_id = uid("fk:" + fk_name), uid("fkindex:" + fk_name)
            usages = "".join(f'<colUsage columnID="{colids[c]}"/>' for c in local_cols)
            index_items.append(f'''<ind_PK_UK id="{index_id}" name="{fk_name}"><createdBy>ricardious</createdBy>
<ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName><indexState>Foreign Key</indexState>
<isSurrogateKey>false</isSurrogateKey><indexColumnUsage>{usages}</indexColumnUsage></ind_PK_UK>''')
            parent_id = table_ids[parent]
            referred_key = key_ids[(parent, tuple(ref_cols))]
            fk_xml = f'''<?xml version="1.0" encoding="UTF-8"?>
<FKIndexAssociation class="oracle.dbtools.crest.model.design.relational.FKIndexAssociation" directorySegmentName="seg_0" id="{fk_id}" containerWithKeyObject="{tid}" localFKIndex="{index_id}" name="{fk_name}">
<createdBy>ricardious</createdBy><ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName>
<referredTableLongName>{parent}</referredTableLongName><deleteRule>NO ACTION</deleteRule><referredTableID>{parent_id}</referredTableID>
<keyObject>{referred_key}</keyObject><referredKeyID>{referred_key}</referredKeyID><mandatory>true</mandatory>
<refColNames>{','.join(ref_cols)}</refColNames><transferable>true</transferable><rely>false</rely><columnDependencyConstraintGenerateInDDL>true</columnDependencyConstraintGenerateInDDL>
</FKIndexAssociation>'''
            (fk_dir / f"{fk_id}.xml").write_text(fk_xml, encoding="utf-8")
            objects.append(f'   <object objectType="FKIndexAssociation" objectID="{fk_id}" name="{fk_name}" containerID="{tid}" refContainerID="{parent_id}" seqName="seg_0" propertyClassName="oracle.dbtools.crest.model.design.relational.FKIndexAssociation" propertyParentId="{REL_ID}" propertySourceId="{parent_id}" propertyTargetId="{tid}"/>')
        indexes_xml = f'<indexes itemClass="oracle.dbtools.crest.model.design.relational.Index">{"".join(index_items)}</indexes>' if index_items else ""
        xml = f'''<?xml version="1.0" encoding="UTF-8"?>
<Table class="oracle.dbtools.crest.model.design.relational.Table" directorySegmentName="seg_0" id="{tid}" name="{name}">
<createdBy>ricardious</createdBy><ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName>
<adequatelyNormalized>YES</adequatelyNormalized><allowColumnReorder>false</allowColumnReorder>
<existDependencyGenerateInDDl>true</existDependencyGenerateInDDl><parsed>true</parsed>
<columns itemClass="oracle.dbtools.crest.model.design.relational.Column">{''.join(cols)}</columns>{indexes_xml}
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
    ddl_text = DDL.read_text(encoding="utf-8")
    (OUT / "DDL_ORIGEN.sql").write_text(ddl_text, encoding="utf-8")
    ddl_import = "\n\n".join(
        match.group(0)
        for match in re.finditer(r"CREATE TABLE\s+\w+\s*\(.*?\);", ddl_text, re.S | re.I)
    ) + "\n"
    (OUT / "DDL_IMPORTAR_DATAMODELER.sql").write_text(ddl_import, encoding="utf-8")
    DMD.write_text(f'''<?xml version="1.0" encoding="UTF-8"?>
<OSDM_Design class="oracle.dbtools.crest.model.design.Design" name="Modelo_Comercial_La_Estrella" id="{DESIGN_ID}" version="3.5">
<createdBy>ricardious</createdBy><createdTime>2026-09-10 12:00:00 UTC</createdTime>
<ownerDesignName>Modelo_Comercial_La_Estrella</ownerDesignName><capitalNames>true</capitalNames><designId>{DESIGN_ID}</designId>
</OSDM_Design>''', encoding="utf-8")
    print(f"Modelo generado: {len(tables)} tablas, {sum(len(t[1]) for t in tables)} columnas, {sum(len(t[4]) for t in tables)} FK")


if __name__ == "__main__":
    main()
