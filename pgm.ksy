meta:
  id: pgm
  file-extension: pgm
  endian: be
seq:
  - id: savf
    type: savf_header
  - id: main_segment
    type: main_segment_header
  - id: segments
    type: segment
    repeat: eos
    #repeat-expr: main_segment.pgm_header.program_header.segment_table.entries.size    
instances:
  hist:
    pos: 0x1180
    type: program_history_log
  static_activation_header:
    pos: 0x2650
    type: static_activation_header
  static_pbv_array:
    pos: 0x2680
    type: static_pbv_array
  exception_handler_tables:
    pos: 0x2890
    type: eh_tables
  procedure_extension_table:
    pos: 0x2ca0
    type: procedure_extension_table
  call_interface_information_component:
    pos: 0x2fa0
    type: call_interface_information_component
types:
  segment:
    seq:
      - id: segment_type
        type: u2
      - id: segment_size
        type: u2
      - id: new_flags
        type: u1
      - id: flags
        type: u1
      - id: sh_unk0
        size: 2
      - id: parent_address
        type: u8
      - id: sh_unk1
        type: u8
      - id: associated_space
        type: u8
      - id: body
        size: segment_size*0x200-32    
  savf_header:
    seq:
      - id: dummy
        size: 0x1000
  program_history_log:
    seq:
      - id: hist_log_size
        type: u4
      - id: hist_log_entry_count
        type: u4
      - id: wrap_count
        type: u1
      - id: current_entry
        type: u1
      - id: nesting_level
        type: u1
      - id: eye_catcher_hist
        size: 4
      - id: hist_reserved
        type: u1
      - id: hist_entries
        type: hist_entry
        repeat: expr
        repeat-expr: hist_log_entry_count
  hist_entry:
    seq:
      - id: operation_code
        type: u1
      - id: nesting_level
        type: u1
      - id: timestamp
        size: 6
      - id: system_vrm
        type: u2
      - id: status
        type: u1
      - id: associated_data
        size: 5
  main_segment_header:
    seq:
      - id: yysghdr
        type: segment_group_header
      - id: yyepahdr
        type: epa_header
      - id: body
        size: (yysghdr.program_size*0x200)-0xd2
    instances:
      pgm_header:
        # io: _parent._io # TODO create substream for segment?
        pos: 0x2000
        type: program_header
  segment_group_header:
    seq:
      - id: program_type
        type: u2
      - id: program_size
        type: u2
      - id: new_flags
        type: u1
      - id: flags
        type: u1
      - id: sh_unk0
        size: 2
      - id: address
        type: u8
      - id: sh_unk1
        type: u8
      - id: object_space
        type: u8
  epa_header: # Encapsulated Program Architecture Header is the same for all object types
    seq:
      - id: attr1
        type: u1
      - id: jopt
        type: u1
      - id: type
        type: u1 # TODO MI Object type, 02 = PGM
      - id: sh_subtype
        type: u1
      - id: sh_pgm_name
        size: 30
      - id: spatt
        type: u1
      - id: spin
        type: u1
      - id: spsz
        type: u4
      - id: sh_unk2
        type: u4
      - id: pbau
        type: u2
      - id: dver
        type: u2
      - id: time
        size: 8
      - id: upsg
        type: u8
      - id: agsg
        type: u8
      - id: ctsg
        type: u8
      - id: osg
        type: u8
      - id: rcv2
        type: u2
      - id: asp
        type: u2
      - id: perf
        type: u4
      - id: mdts
        type: u8
      - id: jpsg
        type: u8
      - id: cbsg
        type: u8
      - id: jid
        size: 10
      - id: owau
        type: u2
      - id: iplnum
        type: u4
      - id: al1s
        type: u8
      - id: grau
        type: u2
      - id: epa_unk0
        size: 6
      - id: grp
        size: 6
      - id: maxs
        type: u2
      - id: info
        type: u8
      - id: att2
        type: u1
      - id: colb
        type: u1
      - id: levl
        type: u4
      - id: uscnt
        type: u2
      - id: usday
        type: u2
  program_header:
    seq:
      - id: program_header
        type: program_header_base
      - id: program_header_ext
        type: program_header_extension
  program_header_base:
    seq:
      - id: progra_attrs
        size: 8
      - id: version_tbl_ptr
        type: addr
      - id: segment_tbl_ptr
        type: addr
      - id: act_hdr_ptr
        type: addr
      - id: sig_tbl_ptr
        type: addr
      - id: string_dir_ptr
        type: addr
      - id: act_grp_inf_ptr
        type: addr
      - id: act_test
        type: addr
      - id: act_str
        type: addr
      - id: act_end
        type: addr
      - id: act_and_pep_end
        type: addr
      - id: flags
        type: u2
      - id: bring_size
        type: u1
      - id: hyperspc_attrs
        type: u1
      - id: program_state
        type: u2
      - id: obj_chkr_ind
        type: u2
      - id: exp_and_sig_str
        type: u8
      - id: exp_adn_sig_end
        type: u8
      - id: string_dir_str
        type: u8
      - id: string_dir_end
        type: u8
      - id: wrt_pgm_hdr_ptr
        type: addr
      - id: reserved0
        size: 8
      - id: program_type
        type: u1
      - id: reserved1
        size: 3
      - id: pep_mod_nbr
        type: u4
      - id: pep_proc_nbr
        type: u4
      - id: pep_string_id
        type: u4
      - id: pep_min_parms
        type: u2
      - id: pep_max_parms
        type: u2
      - id: program_checksum # Leif
        size: 4
      - id: format_level
        type: u4
      - id: cnv_pgm_tb_info
        type: u8
      - id: reserved2
        size: 24
      - id: unknown1
        type: u4
      - id: pgm_hdr_ext
        type: addr
      - id: trcbck_loc_ptr
        type: addr
      - id: module_tbl_ptr
        type: addr
      - id: obs_info_ptr
        type: addr
      - id: main_hdr_ptr
        type: addr
      - id: examp_ptr
        type: addr
    instances:
      pgm_version_table:
        io: _root._io
        pos: version_tbl_ptr.offset+0x1000
        type: program_version_table
      segment_table:
        io: _root._io
        pos: segment_tbl_ptr.offset+0x1000
        type: segment_table
      activation_header:
        io: _root._io
        pos: act_hdr_ptr.offset+0x1000
        type: activation_header
      program_string_directory:
        io: _root._io
        pos: string_dir_ptr.offset+0x1000
        type: program_string_directory
      activation_group_information:
        io: _root._io
        pos: act_grp_inf_ptr.offset+0x1000
        type: activation_group_information
      writable_pgm_header:
        io: _root._io
        type: writable_program_header
        pos: wrt_pgm_hdr_ptr.offset+0x1000
      traceback_locator_table:
        io: _root._io
        type: traceback_locator_table
        pos: trcbck_loc_ptr.offset+0x1000
      module_table:
        io: _root._io
        pos: module_tbl_ptr.offset+0x1000
        type: module_table
      program_observability_info_header:
        io: _root._io
        type: program_observability_info_header
        pos: obs_info_ptr.offset+0x1000
      program_maintenance_header:
        io: _root._io
        pos: main_hdr_ptr.offset+0x1000
        type: program_maintenance_header
  writable_program_header:
    seq:
      - id: lock_src
        size: 76
      - id: lock_use_cnt
        type: u4
      - id: wph_reserved
        size: 48 # 72?
  program_header_extension:
    seq:
      - id: glu_cd_list_ptr
        type: addr
      - id: pgm_hist_segoff
        type: u8
      - id: foo
        type: u8
      - id: mca_tbl_segoff
        type: u8
      - id: java_stmf_ptr
        type: u8
      - id: reserved0
        size: 40
      - id: hdw_feature_set
        size: 16
      - id: reserved1
        size: 32
      - id: sg_tb_ext_segoff
        type: addr
      - id: reserved2
        size: 96
    instances:
      binder_glue_code_table:
        io: _root._io
        type: binder_glue_code_table
        pos: glu_cd_list_ptr.offset+0x1000
      segment_table_extension:
        io: _root._io
        pos: sg_tb_ext_segoff.offset + 0x1000
        type: segment_table_extension
  program_version_table:
    seq:
      - id: table_version
        type: u1
      - id: bn_vrm_ox_leve
        type: u1
      - id: bn_internal_vrm
        type: u2
      - id: bn_mi_vrm
        type: u2
      - id: target_vrm
        type: u2
      - id: create_on_vrm
        type: u2
      - id: bn_earliest_vrm
        type: u2
      - id: reserved0
        size: 4
      - id: language_vrm
        type: u2
      - id: mm_mi_vrm
        type: u2
      - id: ox_mi_vrm
        type: u2
      - id: ox_internal_vrm
        type: u2
      - id: mm_internal_vrm
        type: u2
      - id: reserved1
        size: 4
      - id: ccsid
        type: u2
      - id: unknown0
        size: 4
      - id: pg_mi_vrm
        type: u2
      - id: pg_earliest_vrm
        type: u2
  segment_table:
    seq:
      - id: table_size
        type: u4
      - id: table_entry_count
        type: u4
      - id: table_version
        type: u1
      - id: interrupted_op
        type: u1
      - id: attributes
        type: u1
      - id: reserved0
        size: 3
      - id: interrupted_seg
        type: u2
      - id: entries
        type: segment_table_entry
        repeat: expr
        repeat-expr: table_entry_count
  segment_table_entry:
    seq:
      - id: segment_address
        type: addr
      - id: limbo_address
        type: addr
      - id: dec_sg_page_count
        type: u2
      - id: segment_use
        type: u1
      - id: compress_sg_ids
        size: 10
      - id: impi_ptr_seg_id
        size: 3
      - id: reserved1
        size: 16
    # NOTE: Segment positions have to be calculated from previous section lengths
    #       This can't be done declaratively, in Kaitai's syntax!
  segment_table_extension:
    seq:
      - id: table_size
        type: u4
      - id: table_entry_count
        type: u4
      - id: table_version
        type: u1
      - id: reserved0
        size: 7
      - id: unknown0
        size: 8
      - id: extension_table
        type: segment_table_extension_table
        size: table_size-24 # Header data included!
  segment_table_extension_table:
    seq:
      - id: entries
        type: segment_table_extension_entry
        repeat: expr
        repeat-expr: _parent.table_entry_count
  segment_table_extension_entry:
    seq:
      - id: bytes_used
        type: u4
      - id: reserved0
        size: 20
  activation_group_information:
    seq:
      - id: target
        type: u1
      - id: reserved0
        type: u1
      - id: storage_select
        type: u1
      - id: reserved1
        type: u1
      - id: name
        size: 30 # TODO
      - id: reserved2
        type: u2
      - id: heap_crt_size
        type: u4
      - id: heap_ext_size
        type: u4
      - id: heap_crt_opts
        type: u1
      - id: heap_alloc_val
        type: u1
      - id: heap_deallo_val
        type: u1
      - id: pag_options
        type: u1
      - id: reserved3
        size: 80 
  activation_header:
    seq:
      - id: pep_entry_point # https://www.ibm.com/docs/en/i/7.3?topic=concepts-ile-program
        type: addr
      - id: pbv_size
        type: u4
      - id: pbv_origin
        type: u4
      - id: pbv_reloc_ptr
        type: addr
      - id: static_pbv_ptr
        type: addr
      - id: pbv_reloc_cnt
        type: u4
      - id: dep_srvpgm_cnt
        type: u4
      - id: dep_srvpgm_arry
        type: u8
      - id: static_fdef_ptr
        type: addr
      - id: static_fdef_cnt
        type: u4
      - id: glob_stat_fr_count
        type: u4
      - id: static_sec_fr_cnt
        type: u4
      - id: tl_stat_fr_cnt
        type: u4
      - id: cond_st_fr_cnt
        type: u4
      - id: const_frame_cnt
        type: u4
      - id: const_frame_ptr
        type: addr
      - id: exprt_arry_ptr
        type: addr
      - id: exprt_arry_cnt
        type: u4
      - id: data_export_cnt
        type: u4
      - id: proc_export_cnt
        type: u4
      - id: exprt_alias_cnt
        type: u4
      - id: exprt_alias_ptr
        type: addr
      - id: func_loctr_ptr
        type: addr
      - id: func_loctr_cnt
        type: u4
      - id: addr_tkn_fn_cnt
        type: u4
      - id: non_argopt_cnt
        type: u4
      - id: argopt_fn_cnt
        type: u4
      - id: leg_unrs_fn_ptr
        type: addr
      - id: leg_unrs_fn_cnt
        type: u4
      - id: data_loctr_cnt
        type: u4
      - id: data_locatr_ptr
        type: addr
      - id: fnc_import_ptr
        type: addr
      - id: fnf_import_cnt
        type: u4
      - id: data_import_cnt
        type: u4
      - id: data_import_ptr
        type: addr
      - id: unrs_dir_fn_ptr
        type: addr
      - id: unrs_dir_fn_cnt
        type: u4
      - id: dyn_dat_exp_cnt
        type: u4
      - id: dyn_dat_exp_ptr
        type: addr
      - id: ext_data_tb_ptr
        type: addr
      - id: jv_perm_cls_ptr
        type: addr
      - id: jv_prm_hash_ptr
        type: addr
      - id: data_size_ptr
        type: addr
      - id: reserved
        size: 0x30
  program_string_directory:
    seq:
      - id: dir_length
        type: u4
      - id: unknown
        size: 12
      - id: string_directory
        type: string_directory_entries_ff
        size: dir_length - 16
  string_directory_entries_ff:
    seq:
      - id: entries
        type: prefixed_string_ff
        repeat: eos
  prefixed_string_ff:
    seq:
      - id: len_string_bytes
        type: u4
      - id: unknown0
        size: 2
      - id: string_bytes
        size: len_string_bytes
  string_directory_entries:
    seq:
      - id: entries
        type: prefixed_string
        repeat: eos
  prefixed_string:
    seq:
      - id: len_string_bytes
        type: u4
      - id: string_bytes
        size: len_string_bytes
  program_maintenance_header:
    seq: 
      - id: version
        type: u1
      - id: reserved0
        size: 7
      - id: cpyr_list_size
        type: u4
      - id: cpyr_list_cnt
        type: u4
      - id: cpyr_segoff
        type: u8
      - id: reserved1
        size: 16
      - id: ext_obj_segoff
        size: 8
      - id: stc_act_segoff
        type: u8
      - id: last_seg_nonobs
        type: u4
      - id: last_siz_nonobs
        type: u4
      - id: lowest_pbv_id
        type: u4
      - id: highest_pbv_id
        type: u4
      - id: exp_info_segoff
        type: u8
      - id: reserved
        size: 0x28
      - id: undocumented_program_checksum
        type: u8
  static_activation_header:
    seq:
      - id: pg_address
        type: u8
      - id: reserved0
        size: 0x18
  static_pbv_array:
    seq:
      - id: entries
        type: u8
        repeat: expr
        repeat-expr: 4 
  module_table:
    seq:
      - id: table_size
        type: u4
      - id: table_entry_cnt
        type: u4
      - id: table_version
        type: u1
      - id: reserved
        size: 7
      - id: table_entries
        type: module_table_entry
        size: table_size-16
        repeat: expr
        repeat-expr: table_entry_cnt # TODO are reserved bytes part of the entry or the table?
  #srvpgm_proc_export_info_entries:
  #  seq:
  #    - id: entries
  #      type: srvpgm_proc_export_info_entry
  #      repeat: expr
  #      repeat-expr: _parent.table_entry_cnt # TODO are reserved bytes part of the entry or the table?
  module_table_entry:
    seq:
      - id: module_hdr_ptr
        type: addr
      - id: reserved0
        size: 4
      - id: module_domain
        type: u2
      - id: assoc_spc_cnt
        type: u2
      - id: module_subtype
        type: u1
    instances:
      modules:
        io: _root._io
        pos: module_hdr_ptr.offset+0x1000
        type: module_header
  module_header:
    seq:
      - id: version
        type: u1
      - id: mod_type
        type: u1
      - id: mod_state
        type: u2
      - id: reserved0
        type: u4
      - id: program_hdr_ptr
        type: addr
      - id: cpyr_tbl_ptr
        type: addr
      - id: segment_tbl_ptr
        type: addr
      - id: version_tbl_ptr
        type: addr
      - id: bind_info_ptr
        type: addr
      - id: stat_info_ptr
        type: addr
      - id: eol_tbl_ptr
        type: addr
      - id: obs_info_ptr
        type: addr
      - id: string_dir_ptr
        type: addr
      - id: entrypt_tbl_ptr
        type: addr
      - id: vlic_tbl_ptr
        type: addr
      - id: pkg_info_ptr
        type: addr
      - id: proc_tbl_ptr
        type: addr
      - id: mod_const_ptr
        type: addr
      - id: ehdt_ptr
        type: addr
      - id: ehmtla_ptr
        type: addr
      - id: mot_mod_brg_ptr
        type: addr
      - id: pre_pkg_brg_ptr
        type: addr
      - id: mi_ptr_con_area
        type: u8
      - id: reserved1
        type: u8
      - id: mod_attrs
        type: u2
      - id: mod_obj_aattrs
        type: u2
      - id: pep_dict_id
        type: u4
      - id: pep_string_id
        type: u4
      - id: pep_proc_number
        type: u4
      - id: pep_min_parms
        type: u2
      - id: pep_max_parms
        type: u2
      - id: max_mbv_id_used
        type: u4
      - id: mod_const_body
        type: u1
      - id: xlation_reason
        type: u1
      - id: pdc_attrs
        type: u1
      - id: hyperspc_attrs
        type: u1
      - id: format_level
        type: u4
      - id: mod_hdr_ext_ptr
        type: addr
      - id: segtb_ext_segoff
        type: u8
      - id: reserved2
        size: 32
      - id: undocumented_module_checksum
        type: u8
    instances:
      module_string_directory:
        io: _root._io
        pos: string_dir_ptr.offset+0x1000
        type: module_string_directory
      module_version_table:
        io: _root._io
        pos: version_tbl_ptr.offset+0x1000
        type: version_table
      procedure_table:
        io: _root._io
        pos: proc_tbl_ptr.offset+0x1000
        type: procedure_table
      module_header_extension:
        io: _root._io
        pos: mod_hdr_ext_ptr.offset+0x1000 # 16 bytes after undocumented uint64!
        type: module_header_extension
      module_observability_information:
        io: _root._io
        type: module_observability_information
        pos: obs_info_ptr.offset+0x1000 
  module_header_extension:
    seq:
      - id: version
        type: u1
      - id: reserved0
        size: 7
      - id: call_int_proc
        type: u8
      - id: proc_ext_tbl
        type: u8
      - id: sep_table
        type: u8
      - id: mca_init_segoff
        type: u8
      - id: dcf_init_segoff
        type: u8
      - id: mod_hist_segoff
        type: u8
      - id: dcall_segoff
        type: u8
      - id: icall_segoff
        type: u8
      - id: reserved1
        size: 8
      - id: inl_call_segoff
        type: u8
      - id: dlt_proc_segoff
        type: u8
      - id: licopt_segoff
        type: u8
      - id: jva_crt_segoff
        type: u8
      - id: hdw_feature_set
        size: 16
      - id: effectv_tgt_mdl
        type: u4
      - id: specified_tgt_mdl
        type: u4
      - id: reserved2
        size: 24
      - id: intrface_segoff
        type: u8
      - id: ox_env_flags
        type: u8
      - id: ildata_tbl_segoff
        type: u8
      - id: reserved3
        size: 64
      - id: undocumented_module_ext_checksum
        type: u8
  version_table:
    seq:
      - id: version
        type: u1
      - id: mm_vrm_ox_level
        type: u1
      - id: language_vrm
        type: u2
      - id: mm_vrm
        type: u2
      - id: ox_vrm
        type: u2
      - id: mod_int_vrm
        type: u2
      - id: instruction_vrm
        type: u2
      - id: target_vrm
        type: u2
      - id: create_on_vrm
        type: u2
      - id: opt_level
        type: u2
      - id: ccsid
        type: u2
      - id: from_mod_name
        size: 30
      - id: from_mod_qual
        size: 30
      - id: compiler_name
        size: 20
      - id: early_comp_vrm
        type: u2
      - id: reserved0
        type: u2
  call_interface_information_component:
    seq:
      - id: length
        type: u4
      - id: version
        type: u4
      - id: num_of_prototypes0
        type: u4
      - id: num_of_prototypes1
        type: u4
      - id: reserved0
        size: 16
      - id: entries
        repeat: expr
        repeat-expr: num_of_prototypes0 
        type: ciic_entry
  ciic_entry:
    seq:
      - id: reserved1
        type: u1
      - id: param_index
        size: 3
      - id: flags
        type: u2
      - id: reserved2
        size: 2
  module_string_directory:
    seq:
      - id: dir_length
        type: u4
      - id: reserved0
        size: 12
      - id: entries
        size: dir_length-16
        type: string_directory_entries
  procedure_table:
    seq:
      - id: table_size
        type: u4
      - id: table_entry_cnt
        type: u4
      - id: reserved0
        size: 8
      - id: entries
        #size: table_size-16
        type: procedure_table_entry
        repeat: expr
        repeat-expr: table_entry_cnt
  procedure_table_entry:
    seq:
      - id: version
        type: u1
      - id: proc_type
        type: u1
      - id: proc_bdy
        type: u1
      - id: proc_flags
        type: u1
      - id: proc_lex_scope
        type: u2
      - id: proc_parml_mask
        type: u2
      - id: proc_size
        type: u4
      - id: entry_pt_offset
        type: u4
      - id: entry_point # !!!
        type: addr
      - id: mod_hdr_ptr
        type: addr
      - id: proc_start_ptr
        type: addr
      - id: irm_ptr
        type: addr
      - id: somv_ptr
        type: addr
      - id: st_ptr # string table?
        type: addr
      - id: bpt_ptr
        type: addr
      - id: proc_int_segoff
        type: u8
      - id: reserved0
        size: 24
      - id: icb_size
        type: u4
      - id: string_id
        type: u4
      - id: proc_dict_id
        type: u4
      - id: mod_number
        type: u4
      - id: proc_number
        type: u4
      - id: ofs_to_eh_state
        type: u8            # This way reserved byte count add up to 12 
                            # in case of a single entry just as displayed 
                            # by SST. Also, this is an offset.
      - id: reserved1
        size: 12
    instances:
      risc_code:
        io: _root._io
        pos: proc_start_ptr.offset+0x1000 # TODO review
        size: proc_size
  procedure_extension_table:
    seq:
      - id: table_size
        type: u4
      - id: table_entry_cnt
        type: u4
      - id: reserved0
        size: 8
      - id: entries
        size: table_size-16
        type: procedure_ext_table_entry
        repeat: expr
        repeat-expr: table_entry_cnt
  procedure_ext_table_entry:
    seq:
      - id: version
        type: u1
      - id: basic_blk_attrs
        type: u1
      - id: reserved0
        size: 2
      - id: offset_to_auto
        type: u4
      - id: reserved
        size: 4
      - id: trcbck_tbl_size
        type: u4
      - id: trcbck_tbl_ptr
        type: u8
      - id: reserved1
        size: 36
      - id: interface_idx # Is this still part of the entry?
        type: u4
      - id: argopt_sep_index
        type: u4
      - id: num_of_dcfe
        type: u4
      - id: num_of_idcfe
        type: u4
      - id: first_dir_flow
        type: u4
      - id: first_dir_site
        type: u4
      - id: first_ind_site
        type: u4
      - id: auto_stor_size
        type: u4
      - id: int_prc_call_ct
        type: u4 
  eh_tables:
    seq:
      - id: eh_mapping_table
        type: exception_handler_mapping_table
      - id: eh_declaration_table
        type: exception_handler_declaration_table  
  exception_handler_mapping_table:
    seq:
      - id: length
        type: u4
      - id: version
        type: u4
      - id: last_entry_idx
        type: u4
      - id: entries
        type: u4
        repeat: expr
        repeat-expr: last_entry_idx
  exception_handler_declaration_table:
    seq:
      - id: length
        type: u4
      - id: version
        type: u4
      - id: last_entry_idx
        type: u4
      - id: reserved0
        type: u4
      - id: pgm_model
        type: u1
      - id: reserved1
        size: 1
      - id: opm_exc_mon_cnt
        type: u2 # Maybe? 
      - id: iexit_entry
        type: u4 # Maybe?
      - id: reserved2
        size: 8
      - id: entries
        type: eh_declaration_entry
        repeat: expr
        repeat-expr: last_entry_idx
  eh_declaration_entry:
    seq:
      - id: entry_type
        type: u1 # TODO enum
      - id: hndlr_proc_type
        type: u1
      - id: priority
        type: u1
      - id: reserved0
        size: 1
      - id: data_area_len
        type: u4
      - id: data_ar_stg_key
        type: u1
      - id: data_ar_stg_data
        size: 7
      - id: ctrl_ac_stg_key
        type: u1
      - id: ctrl_ac_stg_data
        size: 7
      - id: hdl_prc_stg_key
        type: u1
      - id: hdl_prc_stg_data
        size: 7
      - id: exception_class
        size: 8
      - id: backup_hnd_ptyp
        type: u1
      - id: reserved1
        size: 3
      - id: backup_slot
        type: u4
      - id: backup_slot2
        type: u4
      - id: backup_slot3
        type: u4
  module_observability_information:
    seq:
      - id: version
        type: u1 
      - id: reserved
        size: 7
      - id: crtmod_tmpl_ptr
        type: u8
      - id: dictionary_ptr
        type: u8
      - id: alias_ptr
        type: u8
      - id: type_info_ptr
        type: u8
      - id: lit_pool_ptr
        type: u8
      - id: instruction_ptr
        type: u8
      - id: init_ptr
        type: u8
      - id: bind_spec_ptr
        type: u8
      - id: dmt_ptr
        type: addr
      - id: tmpl_ext_segoff
        type: u8
      - id: bbp_segoff
        type: u8
      - id: func_pro_segoff
        type: u8
      - id: class_1_obs_crt
        type: u4
      - id: obs_exist_now
        type: u4
      - id: obs_deletable
        type: u4
      - id: reserved0
        size: 12
    instances:
      dictionary_mapping_table:
        type: dictionary_mapping_table
        pos: dmt_ptr.offset+0x1000
  dictionary_mapping_table:
    seq:
      - id: length
        type: u4
      - id: version
        type: u4
      - id: last_entry_idx
        type: u4
      - id: entries
        size: length-12
        type: directory_mapping_entry
        repeat: expr
        repeat-expr: last_entry_idx
  directory_mapping_entry:
    seq:
      - id: dictionary_id
        type: u4 
      - id: offset
        type: u4
      - id: flags
        type: u1
      - id: storage_frame
        type: u2 # Maybe?
      - id: lexscope_or_res
        type: u1
      - id: mbv_or_length
        type: u4
      - id: pbv_or_owner
        type: u4
  binder_glue_code_table:
    seq:
      - id: table_size
        type: u4
      - id: table_entry_cnt
        type: u4
      - id: gc_nxt_tbl_lnk
        type: u8
      - id: gc_table_type
        type: u1
      - id: reserved0
        size: 15
  traceback_locator_table:
    seq:
      - id: table_size
        type: u4 
      - id: table_entry_cnt
        type: u4
      - id: table_version
        type: u1
      - id: reserved0
        size: 7
      - id: entries
        size: table_size - 16
        repeat: expr
        repeat-expr: table_entry_cnt
        type: traceback_locator_entry
  traceback_locator_entry:
    seq:
      - id: proc_location
        type: u8
      - id: proc_length
        type: u4
      - id: reserved0
        type: u4
      - id: traceback_tbl_loc
        type: u8
  program_observability_info_header:
    seq:
      - id: version
        type: u1
      - id: reserved0
        size: 3
      - id: obs_must_remain
        type: u4
      - id: obs_exist_crt
        type: u4
      - id: obs_exist_now
        type: u4
      - id: pgm_crt_tpl_ptr
        type: u8
      - id: object_list_ptr
        type: u8
      - id: sys_res_lis_ptr
        type: u8
      - id: pgm_ex_list_ptr
        type: u8
      - id: sec_spc_list_ptr
        type: u8
      - id: opm_tpl_inf_ptr
        type: addr
      - id: proc_ord_segoff
        type: u8
      - id: reserved1
        size: 8
    instances:
      opm_template_info_header:
        io: _root._io
        pos: opm_tpl_inf_ptr.offset+0x1000
        type: opm_template_info_header
  opm_template_info_header:
    seq:
      - id: version
        type: u1
      - id: reserved0
        size: 7
      - id: opm_crt_tpl_ptr
        type: u8
      - id: reserved1
        size: 16
      - id: pgm_attrs
        type: u2
      - id: opm_options
        type: u1
      - id: observ_attr
        type: u1
      - id: static_store_sz
        type: u4
      - id: auto_store_size
        type: u4
      - id: num_instr_v0
        type: u2
      - id: num_odv_ent_v0
        type: u2
      - id: mi_instr_offset
        type: u4
      - id: odv_offset
        type: u4
      - id: oes_offset
        type: u4
      - id: hll_bom_dta_len
        type: u4
      - id: hll_bom_length
        type: u4
      - id: hll_bom_offset
        type: u4
      - id: hll_sym_dta_len
        type: u4
      - id: hll_sym_length
        type: u4
      - id: hll_sym_offset
        type: u4
      - id: omt_offset
        type: u4
      - id: num_instr_v1
        type: u4
      - id: num_odv_ent_v1
        type: u4
      - id: reserved
        size: 96 # Maybe?
  addr:
    seq:
      - id: dwhigh
        type: u4
      - id: dwlow
        type: u4
    instances:
      offset:
        value: dwlow & 0xffffff
      page:
        value: (dwhigh << 8) + ((dwlow & 0xff000000) >> 24)
      fullvalue:
        value: (dwhigh << 32) + dwlow
enums:
  object_type:
    1: access_group
    2: pgm
    3: module
    4: permanent_context
    5: temporary_context
    6: byte_string_space
    7: journal_space
    8: user_profile
    9: journal_port
    10: queue
    11: data_space
    12: data_space_index
    13: cursor
    14: index
    15: commit_block
    16: device_description
    17: line_description
    18: controller_description
    19: dump_space
    20: class_of_service
    21: mode
    22: network_interfce_description
    23: connection_list
    24: queue_space
    25: space
    26: process_control_space
    27: authorization_list
    28: dictionary
    29: auxiliary_server_description
    30: byte_stream_file
    33: composite_object_group
    34: directory
    35: transaction_control_structure
    36: machine_context
    37: stream
