<template>
  <div>
    <h1>Teams</h1>
    <table class="table table-bordered table-striped">
      <thead class="thead-dark">
        <tr>
          <th>Navn</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="team in teams" :key="team.id">
          <td>
            <h1>
              <span class="badge badge-primary" :style="{backgroundColor: team.background_color}">
                {{ team.name }}
              </span>
            </h1>
          </td>
          <td>
            <button type="button" class="btn btn-outline-danger" @click="destroy(team.id)">
              <b-icon-trash /> Slet
            </button>
          </td>
        </tr>
      </tbody>
    </table>

    <div class="input-group">
      <input type="text" class="form-control" v-model="name" placeholder="Holdnavn">
      <div class="input-group-append" id="button-addon4">
        <v-swatches v-model="background_color">
          <button slot="trigger" type="button" name="button" class="btn btn-outline-primary">
            <b-icon-brush /> Farve
          </button>
        </v-swatches>
        <button class="btn btn-outline-secondary" type="button" @click="create" :disabled="!name && !background_color">Gem</button>
      </div>
    </div>

  </div>
</template>

<script type="text/javascript">
import { Team } from '../services'
import VSwatches from 'vue-swatches'

export default {
  components: { VSwatches },
  data() {
    return {
      name: '',
      background_color: '',
      teams: []
    }
  },
  methods: {
    destroy(team_id) {
      Team.delete({game_id: this.game_id, id: team_id}).then(() => {
        this.$emit('input', this.teams);
        this.query();
      })
    },
    create() {
      let data = {
        name: this.name,
        background_color: this.background_color
      };
      Team.save({game_id: this.game_id}, data).then(() => {
        this.$emit('input', this.teams);
        this.query();
      })
    },
    query() {
      Team.query({game_id: this.game_id}).then((response) => {
        this.teams = response;
      });
    }
  },
  props: {
    game_id: {
      type: String,
      required: true
    }
  },
  created() {
    this.query()
  }
}
</script>
